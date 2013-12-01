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
	# This class provides the network IO logic for Wired protocol
	# communications. It wraps a Ruby socket object and many attributes
	# required to comply with the Wired network protocol, including
	# data serialization, compression and encryption of data.
	class Socket
		require 'socket'
		require 'timeout'
		require 'openssl'
		require 'zlib'


		# The default length size of a binary field
		SOCKET_LENGTH_SIZE		= 4

		# The maximal size of a binary message
		SOCKET_MAX_BINARY_SIZE 	= (10 * 1024 * 1024)



		# This module enumerates supported serialization modes
		module Serialization
			# XML serialization of data
		  	XML 	=  0
		  	# Binary serialization of data
		  	BINARY 	=  1
		end


		# This module enumerates supported compression modes
		module Compression
			# No compression
			NONE 	= -1
			# Gzip compression enabled
			DEFLATE =  0
		end
 

		# This module enumerates supported compression algorithms
		module Checksum
			# Secure Hash algorithm standard (NIST: FIPS)
		  	SHA1 =  0
		end


		# This module enumerates supported encryption ciphers
		module Cipher
			# No cipher (communication will not be encrypted)
		  	NONE 			= -1
		  	# RSA Advanced Encryption Standard 128 bits
		  	RSA_AES_128 	=  0
		  	# RSA Advanced Encryption Standard 192 bits
		  	RSA_AES_192 	=  1
		  	# RSA Advanced Encryption Standard 256 bits
		  	RSA_AES_256 	=  2
		  	# RSA Blowfish 128 bits
		  	RSA_BF_128 		=  3
		  	# RSA Data Encryption Standard 192 bits
		  	RSA_3DES_192 	=  4 
		end


		# @return [String] The hostanme for the socket to connect 
		attr_accessor :hostname

		# @return [Integer] The network port for the socket to connect
		attr_accessor :port

		# @return [Wired::Spec] The attached specification object
		attr_accessor :spec

		# @return [Wired::Socket::Serialization] Data serialization mode
		attr_accessor :serialization

		# @return [Wired::Socket::Compression] Data compression mode
		attr_accessor :compression

		# @return [Wired::Socket::Cipher] Data encryption cipher
		attr_accessor :cipher

		# @return [Integer] Connect timeout
		attr_accessor :timeout

		# @return [Array] Array of Wired errors
		attr_accessor :errors

		# @return [Boolean] Compression enabled internally
		attr_reader :compression_enabled

		# @return [Boolean] Encryption enabled internally
		attr_reader :encryption_enabled



		
		def initialize(hostname, spec, options = {})
			@errors				= Array.new
			@hostname 			= hostname
     	 	@spec				= spec
     	 	@socket 			= nil
     	 	@tls_socket			= nil

     	 	@port 				= options[:port] || 4875
     	 	@timeout 			= options[:timeout] || 10.0
     	 	@serialization 		= options[:serialization] || Wired::Socket::Serialization::BINARY
     	 	@compression 		= options[:compression] || Wired::Socket::Cipher::NONE
     	 	@cipher				= options[:cipher] || Wired::Socket::Compression::NONE

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
			# check socket serialization mode
			if(@serialization == Wired::Socket::Serialization::XML)
				message = ""
				# read XML data line by line to compute a message
				while line = @socket.gets
					break if line == "\r\n"
					message = message + line
				end

				# create a message based on XML
				if message.length > 0
					message = Wired::Message.new(:spec => @spec, :xml => message)
					# internally handle the message (logging, errors, etc.)
					handle_message message

					return message
				end

			elsif(@serialization == Wired::Socket::Serialization::BINARY)
				begin
					# read message length
  					length = @socket.readpartial(SOCKET_LENGTH_SIZE).unpack("N")[0]

  					if(length <= 0 || length > SOCKET_MAX_BINARY_SIZE)
  						Wired::LOGGER.error "Invalid message length: " + length.to_s
  						return nil
  					end

  					# read message binary payload
  					binary = @socket.readpartial(length)

  					if binary.length > 0
	  					# decompress data
						if @compression_enabled
							binary = inflate_data(binary) 
						end

						# decrypt data
						if @cipher != Wired::Socket::Cipher::NONE && @public_key != nil
							#binary = @public_key.encrypt(binary)
						end

						# create message with binary data
	  					message = Wired::Message.new(:spec => @spec, :binary => binary)

  						# internally handle the message (logging, errors, etc.)
	  					handle_message message

						return message
	  				end
				rescue Errno::EAGAIN
					IO.select([@socket])
					retry 
				rescue EOFError
				end
				# internally handle the message (logging, errors, etc.)
				handle_message message

				return message
			end
			return nil
		end





		def write(message)
			Wired::LOGGER.debug "Sent Message: " + message.name
			# check socket serialization mode
			if(!@serialization || @serialization == Wired::Socket::Serialization::XML)
				# write the message as XML on the socket
				# \r\n is used as message EOF
				@socket.write message.to_xml.to_s+"\r\n"

			elsif(@serialization == Wired::Socket::Serialization::BINARY)
				# convert message to binary data
				binary = message.to_bin

				# compress binary data
				if @compression_enabled
					binary = deflate_data(binary) 
				end

				# encrypt binary data
				if @cipher != Wired::Socket::Cipher::NONE && @public_key != nil
					#binary = @public_key.encrypt(binary)
				end

				#Wired::LOGGER.debug "Binary Data: " + binary.unpack("H*").to_s
				#Wired::LOGGER.debug "Binary Size: " + binary.length.to_s

				# write binary data length through the sopcket
				@socket.write [binary.length].pack("N");
				# write binary data through the sopcket
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
				"p7.handshake.version" 			=> "1.0",
				"p7.handshake.protocol.name" 	=> "Wired",
				"p7.handshake.protocol.version" => "2.0b55"
				})

			# settings
			if(@serialization == Wired::Socket::Serialization::BINARY)
				if @encryption_enabled
					message.add_parameter("p7.handshake.encryption", @cipher)
				end

				if @compression == Wired::Socket::Compression::DEFLATE
					message.add_parameter("p7.handshake.compression", 0)
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

			if(message.parameter("p7.handshake.compression") == 0)
				@compression_enabled = true
			end

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
			Wired::LOGGER.debug "Received Message: " + message.name

			handle_error message if message.name == "wired.error"
		end




	    def handle_error(message)
	    	Wired::LOGGER.error "Received Wired error: " + message.to_s
			@errors.push message
	    end




		def deflate_data(data)
		  return Zlib::Deflate.deflate(data)		  
		end




		def inflate_data(data)
		  return Zlib::Inflate.inflate(data)		  
		end
	end
end