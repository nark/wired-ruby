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
		attr_accessor :hostname
		attr_accessor :port
		attr_accessor :spec
		attr_accessor :serialization
		attr_accessor :compression
		attr_accessor :cipher
		attr_accessor :timeout
		attr_accessor :errors



		def initialize(hostname, spec, options = {})
			@errors			= Array.new
			@hostname 		= hostname
     	 	@spec			= spec
     	 	@socket 		= nil
     	 	@tls_socket		= nil

     	 	@port 			= options[:port] || 4875
     	 	@timeout 		= options[:timeout] || 10.0
     	 	@serialization 	= options[:serialization]
     	 	@compression 	= options[:compression]
     	 	@cipher			= options[:cipher] || Wired::Socket::Cipher::NONE

     	 	@private_key	= nil
     	 	@public_key 	= nil
		end



		def connect
			@socket = TCPSocket.new(@hostname, @port)

			#@socket.set_encoding 'UTF-8'

			Wired::LOGGER.error "Connection to #{@hostname}:#{@port} failed" and return false if !@socket
			Wired::LOGGER.error "Handshake to #{@hostname}:#{@port} failed" and return false if !handshake?

			return true
		end



		def diconnect
			@socket.close
		end



		def read
			message = ""

			if(@serialization == Wired::Socket::Serialization::XML)
				while line = @socket.gets
					if line != "\r\n"
						message = message + line
					else
						break
					end
				end
			elsif(@serialization == Wired::Socket::Serialization::BINARY)
				puts @socket.read 
			end

			if message.length > 0
				message = Wired::Message.new(:spec => @spec, :xml => message)
				
				if message.name == "wired.error"
					handle_error message
				else
					Wired::LOGGER.debug "Received Message:\n " + message.to_s + "\n\n"
					return message
				end
			end

			return nil
		end


		def write(message)
			Wired::LOGGER.debug "Sent Message:\n " + message.to_s + "\n\n"

			if(!@serialization || @serialization == Wired::Socket::Serialization::XML)
				@socket.write message.to_xml.to_s+"\r\n"

			elsif(@serialization == Wired::Socket::Serialization::BINARY)
				# convert message to binary data
				binary = message.to_bin

				# compress data
				if @compression == true
					binary = Zlib::Deflate.new(nil, -Zlib::MAX_WBITS).deflate(binary, Zlib::FINISH)
				end

				# encrypt data
				if @cipher != Wired::Socket::Cipher::NONE && @public_key != nil
					binary = @public_key.encrypt(binary)
				end

				#Wired::LOGGER.debug "Binary Data: " + binary.unpack("H*").to_s
				# write data
				@socket.write binary
			end
		end



		def closed?
			return @socket.closed?
		end


		def handshake?
			message = Wired::Message.new(:spec => @spec, :name => "p7.handshake.client_handshake")
			# protocol
			message.add_parameters({
				"p7.handshake.version" => "1.0",
				"p7.handshake.protocol.name" => "Wired",
				"p7.handshake.protocol.version" => "2.0b55"
				})

			# encryption
			if(@serialization == Wired::Socket::Serialization::BINARY)
				message.add_parameter("p7.handshake.encryption", "p7.handshake.encryption.rsa_aes256_sha1")
			end

			write message
			message = read

			if !message
				Wired::LOGGER.error "Should Receive Message: p7.handshake.server_handshake" + message.to_s
				return false
			end

			if (message.name != "p7.handshake.server_handshake")
				Wired::LOGGER.error "Unexpected message " + message.name + " instead of p7.handshake.server_handshake";
				return false
			end

			message = Wired::Message.new(:spec => @spec, :name => "p7.handshake.acknowledge")
			message.add_parameter("p7.handshake.compatibility_check", false)
			write message

			message = Wired::Message.new(:spec => @spec, :name => "p7.compatibility_check.specification")
			message.add_parameter("p7.compatibility_check.specification", @spec.doc.to_xml.to_s)
			write message

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
		def next_line_readable?
	      readfds, writefds, exceptfds = select([@socket], nil, nil, 0.1)
	      p :r => readfds, :w => writefds, :e => exceptfds
	      readfds #Will be nil if next line cannot be read
	    end


	    def handle_error(message)
	    	Wired::LOGGER.error "Received Wired error: " + message.to_s
			@errors.push message
	    end
	end
end