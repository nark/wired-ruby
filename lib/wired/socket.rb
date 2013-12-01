# == socket.rb
# This file contains the Wired::Socket class definition.
#
# == Example
#
# 	socket = Wired::Socket.new(url.hostname, url.port)
# 	socket.connect
#
# == Contact
#
# Author::  Rafaël Warnault (mailto:dev@read-write.fr)
# Website:: http://wired.read-write.fr
# Date::    Saturday May 29, 2013
#
module Wired
	class Socket
		require 'socket'
		require 'timeout'
		require 'openssl'
		require 'zlib'

		SOCKET_LENGTH_SIZE		= 4
		SOCKET_MAX_BINARY_SIZE 	= (10 * 1024 * 1024)

		# Data Serialization Modes
		module Serialization
		  XML 			= 0
		  BINARY 		= 1
		end
 

		# Checksum Types
		module Checksum
		  SHA1 			= 0
		end


		# Encryption Ciphers
		module Cipher
		  NONE			= -1
		  RSA_AES_128 	= 0
		  RSA_AES_192 	= 1
		  RSA_AES_256 	= 2
		  RSA_BF_128 	= 3
		  RSA_3DES_192 	= 4
		end

		# Accessors
		attr_accessor 	:hostname
		attr_accessor 	:port
		attr_accessor 	:spec
		attr_accessor 	:serialization
		attr_accessor 	:compression
		attr_accessor 	:cipher
		attr_accessor 	:timeout
		attr_accessor 	:errors

		attr_reader		:compression_enabled
		attr_reader		:encryption_enabled


		def initialize(hostname, spec, options = {})
			@errors				= Array.new
			@hostname 			= hostname
     	 	@spec				= spec
     	 	@socket 			= nil
     	 	@tls_socket			= nil

     	 	@port 				= options[:port] || 4875
     	 	@timeout 			= options[:timeout] || 10.0
     	 	@serialization 		= options[:serialization]
     	 	@compression 		= options[:compression]
     	 	@cipher				= options[:cipher] || Wired::Socket::Cipher::NONE

     	 	@private_key		= nil
     	 	@public_key 		= nil

     	 	@encryption_enabled = (@cipher != Wired::Socket::Cipher::NONE)
		end





		def connect
			# overwrite localhost if needed
			if(@hostname == "localhost")
				@hostname = "127.0.0.1"
			end

			# create a new socket for connection
			@socket  	= Socket::Socket.new(:INET, :STREAM)
			remote_addr = Socket::Socket.pack_sockaddr_in(@port, @hostname)

			# connect the socket with a timeout
			begin
				@socket.connect(remote_addr)
			rescue Errno::EINPROGRESS
				if IO.select(nil, [@socket], nil, @timeout)
					retry 
				else
				  raise Timeout::Error
				  Wired::LOGGER.error "Connection to #{@hostname}:#{@port} timeout" and return false
				end
			end

			# perform the Wired protocol handshake
			if !connect_handshake?
				Wired::LOGGER.error "Handshake to #{@hostname}:#{@port} failed" 
				return false 
			end

			return true
		end





		def diconnect
			@socket.close
		end





		def read
			message = nil

			if(@serialization == Wired::Socket::Serialization::XML)
				message = ""

				while line = @socket.read
					if line != "\r\n"
						message = message + line
					else
						break
					end
				end

				if message.length > 0
					message = Wired::Message.new(:spec => @spec, :xml => message)
					
					handle_message message

					return message
				end

			elsif(@serialization == Wired::Socket::Serialization::BINARY)
				begin
  					length 	= read_binary_data(SOCKET_LENGTH_SIZE, "N")

  					if(length <= 0 || length > SOCKET_MAX_BINARY_SIZE)
  						Wired::LOGGER.error "Invalid message length: " + length.to_s
  						return nil
  					end

  					id 		= @socket.readpartial(SOCKET_LENGTH_SIZE).unpack("N")[0]
  					message = Wired::Message.new(:spec => @spec, :id => id.to_s)

  					if(message == nil)
  						Wired::LOGGER.error "Unknow message with id: " + id.to_s
  						return nil
  					end

  					read_size = 0

  					while ((read_size < length) && (bin = @socket.readpartial(SOCKET_LENGTH_SIZE))) do
  						name, value, size = read_binary_field(bin)

  						message.add_parameter(name, value)

  						read_size += (SOCKET_LENGTH_SIZE * 2) + size

  						break if (read_size > length || (length-read_size) < SOCKET_LENGTH_SIZE)
  					end

				rescue Errno::EAGAIN
					IO.select([@socket])
					retry 
				rescue EOFError
				end

				handle_message message

				return message
			end
			return nil
		end





		def write(message)
			Wired::LOGGER.debug "Sent Message:\n " + message.name + "\n\n"

			if(!@serialization || @serialization == Wired::Socket::Serialization::XML)
				@socket.write message.to_xml.to_s+"\r\n"

			elsif(@serialization == Wired::Socket::Serialization::BINARY)
				# convert message to binary data
				binary = message.to_bin

				# compress data
				if @compression_enabled
					binary = deflate_data(binary) 
				end

				# encrypt data
				if @cipher != Wired::Socket::Cipher::NONE && @public_key != nil
					#binary = @public_key.encrypt(binary)
				end

				#Wired::LOGGER.debug "Binary Data: " + binary.unpack("H*").to_s
				#Wired::LOGGER.debug "Binary Size: " + binary.length.to_s

				# write data
				@socket.write [binary.length].pack("N");
				@socket.write binary
			end
		end





		def closed?
			return @socket.closed?
		end




		def connect_handshake?
			message = Wired::Message.new(:spec => @spec, :name => "p7.handshake.client_handshake")
			# protocol
			message.add_parameters({
				"p7.handshake.version" => "1.0",
				"p7.handshake.protocol.name" => "Wired",
				"p7.handshake.protocol.version" => "2.0b55"
				})

			# settings
			if(@serialization == Wired::Socket::Serialization::BINARY)
				if @encryption_enabled
					message.add_parameter("p7.handshake.encryption", Wired::Socket::Cipher::RSA_AES_256)
				end

				if @compression
					message.add_parameter("p7.handshake.compression", 1)
				end
			end

			write message
			message = read

			if !message
				Wired::LOGGER.error "Should Receive Message: p7.handshake.server_handshake"
				return false
			end

			if (message.name != "p7.handshake.server_handshake")
				Wired::LOGGER.error "Unexpected message " + message.name + " instead of p7.handshake.server_handshake";
				return false
			end

			puts message.to_xml
			#@compression_enabled = @compression if @compression = true

			message = Wired::Message.new(:spec => @spec, :name => "p7.handshake.acknowledge")
			message.add_parameter("p7.handshake.compatibility_check", false)
			write message

			message = Wired::Message.new(:spec => @spec, :name => "p7.compatibility_check.specification")
			message.add_parameter("p7.compatibility_check.specification", @spec.doc.to_xml.to_s)
			write message

			message = read

			return true
		end





		# def connect_handshake
		# 	ssl_context = OpenSSL::SSL::SSLContext.new()
		# 	#ssl_context.cert = OpenSSL::X509::Certificate.new(File.open("certificate.crt"))
		# 	#ssl_context.key = OpenSSL::PKey::RSA.new(File.open("certificate.key"))
		# 	ssl_context.ssl_version = :SSLv23

		# 	@socket = OpenSSL::SSL::SSLSocket.new(@socket, ssl_context)
		# 	@socket.sync_close = true

		# 	@socket.connect
		# end


	private
		def handle_message(message) 
			Wired::LOGGER.debug "Received Message:\n " + message.name + "\n\n"

			handle_error message if message.name == "wired.error"
		end




	    def handle_error(message)
	    	Wired::LOGGER.error "Received Wired error: " + message.to_s
			@errors.push message
	    end




		def read_binary_data(length, format)
			data = @socket.readpartial(length)

			if @compression_enabled
				data = inflate_data(data)
			end

			data = data.unpack(format)[0]

			return data
		end




		def read_binary_field(binary)
			field_id 	= binary.unpack("N")[0]
			field 		= @spec.spec_field_with_id(field_id.to_s)

			if(field == nil)
				Wired::LOGGER.error "Unknow field with id: " + id.to_s
				return nil
			end

			size 		= @socket.readpartial(SOCKET_LENGTH_SIZE).unpack("N")[0].to_i || 0
			value 		= read_binary_field_value(field, size)
			name 		= field.name

			return name, value, size
		end




		def read_binary_field_value(field, size)
			value = @socket.readpartial(size).unpack("H" + (size+2).to_s)[0]

			# Wired types: bool, enum, int32, uint32, int64, uint64, double 
			# string, uuid, date, data, oobdata, list
			case field.type
			when "string"
			  value = [value].pack("H*")

			when "bool"
			when "enum"
			when "int32"
			when "uint32"
			  value = value.to_i
			else
			  Wired::LOGGER.error 'Unknow type:' + field.type
			end

			return value
		end



		def deflate_data(data)
		  return Zlib::Deflate.deflate(data)		  
		end




		def inflate_data(data)
		  return Zlib::Inflate.inflate(data)		  
		end
	end
end