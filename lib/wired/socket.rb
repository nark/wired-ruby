module Wired
	# This class provides the network IO logic for Wired protocol
	# communications. It wraps a Ruby socket object and many attributes
	# required to comply with the Wired network protocol, including
	# data serialization, compression and encryption of data.
	#
	# @example Create a new Wired socket and connect
	# 	socket = Wired::Socket.new(url.hostname, url.port)
	# 	socket.connect
	#
	# @author Rafaël Warnault (mailto:dev@read-write.fr)
	class Socket
		require 'socket'
		require 'timeout'
		require 'openssl'
		require 'digest/sha1'
		#require 'zlib'
		require 'pr/zlib'

		# The default length size of a binary field
		SOCKET_LENGTH_SIZE		= 4

		# The maximal size of a binary message
		SOCKET_MAX_BINARY_SIZE 	= (10 * 1024 * 1024)


		RSA_PKCS1_OAEP_PADDING	= 4


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
		  	SHA1 	=  0
		  	SHA256 	= 1
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

		# @return [String] The username for encryption
		attr_accessor :username

		# @return [String] The password for encryption
		attr_accessor :password

		# @return [Wired::Spec] The attached specification object
		attr_accessor :spec

		# @return [Wired::Socket::Serialization] Data serialization mode
		attr_accessor :serialization

		# @return [Wired::Socket::Compression] Data compression mode
		attr_accessor :compression

		# @return [Wired::Socket::Cipher] Data encryption cipher
		attr_accessor :cipher

		# @return [OpenSSL::Cipher::Cipher] OpenSSL Cipher object
		attr_reader :ssl_cipher

		# @return [Integer] Connect timeout
		attr_accessor :timeout

		# @return [Array] Array of Wired errors
		attr_accessor :errors


		# @return [Boolean] Compression enabled internally
		attr_reader :compression_enabled

		# @return [Boolean] Encryption enabled internally
		attr_reader :encryption_enabled

		# @return [Boolean] Local compatibility check
		attr_reader :local_compatibility_check

		# @return [Boolean] Remote compatibility check
		attr_reader :remote_compatibility_check

		# @return [String] The version of the remote protocol, retrieved during handshake
		attr_reader :remote_version

		# @return [String] The name of the remote protocol, retrieved during handshake
		attr_reader :remote_name

		# @return [Boolean] Socket is connected (mainly used to handle disconnect)
		attr_accessor :connected

		# Initialize a Wired socket object with a hostname, a spec
		# and a hash of options.
		#
		# @param hostname [String] the hostname for the socket to connect
		# @param spec [Wired::Spec] the specification object
		# @param options [Hash] A hash of options
		#
		# @option options [Integer] :port The network port for the socket to connect
		# @option options [Integer] :timeout Connect timeout
		# @option options [Wired::Socket::Serialization] :serialization Data serialization mode
		# @option options [Wired::Socket::Compression] :compression Data compression mode
		# @option options [Wired::Socket::Cipher] :cipher Data encryption cipher
		#
		# @return [Wired::Socket] A Spec instance
		def initialize(hostname, spec, options = {})
			@errors				= Array.new
			@hostname 			= hostname
     	 	@spec				= spec
     	 	@socket 			= nil
     	 	@tls_socket			= nil

     	 	@port 				= options[:port] || 4875
     	 	@timeout 			= options[:timeout] || 10.0
     	 	@username 			= options[:username] || "guest"
     	 	@password 			= options[:password] || ""
     	 	@serialization 		= options[:serialization] || Wired::Socket::Serialization::BINARY
     	 	@compression 		= options[:compression] || Wired::Socket::Compression::NONE
     	 	@cipher				= options[:cipher] || Wired::Socket::Cipher::RSA_AES_256

     	 	@private_key		= nil
     	 	@public_key 		= nil
     	 	@ssl_cipher			= nil

     	 	@connected 			= false
		end




		# Connect the Wired socket using initialized parameters.
		#
		# @param handshake [Boolean] Handle the connection handshake for you
		#
		# @note This connect method handles the Wired protocol
		# 	handshake for you by default. This behavior can be disabled 
		# 	using the 'handshake' method parameter.
		#
		# @return [Boolean] Return true if the connection succeed,
		# 	and returns false otherwise.
		def connect(handshake = true)
			# overwrite localhost if needed
			if(@hostname == "localhost")
				@hostname = "127.0.0.1"
			end

			# create a new socket for connection
			@socket  	= Socket::Socket.new(:INET, :STREAM)
			remote_addr = Socket::Socket.pack_sockaddr_in(@port, @hostname)

			@socket.set_encoding("ASCII-8BIT")

			# connect the socket with a timeout
			begin
				@socket.connect(remote_addr)
			rescue Errno::EINPROGRESS
				if IO.select(nil, [@socket], nil, @timeout)
					retry 
				else
				  raise Timeout::Error
				  Wired::Log.error "Connection timeout to #{@hostname}:#{@port}" and return false
				end
			end

			@connected = true

			if handshake
				# perform the Wired protocol handshake
				if !connect_handshake?
					Wired::Log.error "Handshake failed to #{@hostname}:#{@port}" 
					return false 
				end

				# perform the Wired key exange
				if !connect_key_exange(nil, nil)
					Wired::Log.error "Handshake failed to #{@hostname}:#{@port}" 
					return false 
				end

				# send compatibility check
				return send_compatibilit_check if @local_compatibility_check
			end

			return true
		end




		# Disconnect the Wired socket
		def diconnect
			@connected = false
			@socket.close
		end




		# Read a message from the Wired socket.
		#
		# @return [Wired::Message] A Wired message instance
		def read
			message = nil
			# check socket serialization mode
			if(@serialization == Wired::Socket::Serialization::XML)
				message = ""
				# read XML data line by line to compute a message
				while line = @socket.gets
					return nil if !@connected
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
					begin
						length = @socket.readpartial(SOCKET_LENGTH_SIZE).unpack("N")[0]
					rescue Exception => e
						return nil
					end

  					if(length <= 0 || length > SOCKET_MAX_BINARY_SIZE)
  						Wired::Log.error "Invalid message length: " + length.to_s
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
						if @encryption_enabled
							binary = @ssl_cipher.decrypt(binary)
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




		# Write a message to the Wired socket.
		#
		# @param message [Wired::Message] A Wired message to send
		def write(message)
			Wired::Log.debug "Sent Message: " + message.name
			# check socket serialization mode
			if(!@serialization || @serialization == Wired::Socket::Serialization::XML)
				# write the message as XML on the socket
				# \r\n is used as message EOF
				xml = message.to_xml.to_s+"\r\n"

				@socket.write xml

			elsif(@serialization == Wired::Socket::Serialization::BINARY)
				# convert message to binary data
				binary = message.to_bin

				# compress binary data
				if @compression_enabled
					binary = deflate_data(binary) 
				end

				# encrypt binary data
				if @encryption_enabled
					binary = @ssl_cipher.encrypt(binary)
				end

				binary_length = binary.length

				# write binary data length through the socket
				@socket.write [binary_length].pack("N")
				# write binary data through the socket
				@socket.write binary
			end
		end


		# Write a message then read and return the response to the Wired socket.
		#
		# @param message [Wired::Message] A Wired message to send
		# @return [Wired::Message] A Wired message instance
		def write_and_read_response(message)
			write message
			return read
		end



		# Informs if the Wired socket is still connected
		#
		# @return [Boolean] Returns false if the commucation is closed,
		# 	otherwise returns true if still up.
		def closed?
			return @socket.closed?
		end



	private
		def connect_handshake?
			# create a client_handshake message
			message = Wired::Message.new(:spec => @spec, :name => "p7.handshake.client_handshake")
			message.add_parameters({
				"p7.handshake.version" 			=> "1.0",
				"p7.handshake.protocol.name" 	=> "Wired",
				"p7.handshake.protocol.version" => "2.0b55"
				})

			# handshake settings
			if(@serialization == Wired::Socket::Serialization::BINARY)
				if @cipher != Wired::Socket::Cipher::NONE
					message.add_parameter("p7.handshake.encryption", @cipher.to_i)
				end

				if @compression != Wired::Socket::Compression::NONE
					message.add_parameter("p7.handshake.compression", 0)
				end
			end

			# write/read message
			message = write_and_read_response message

			# check received handshake message
			if !message
				Wired::Log.error "Handshake Failed: Should Receive Message: p7.handshake.server_handshake"
				return false
			end

			if (message.name != "p7.handshake.server_handshake")
				Wired::Log.error "Handshake Failed: Unexpected message #{message.name} instead of p7.handshake.server_handshake";
				return false
			end

			# check buil-in specification version
			version = message.parameter("p7.handshake.version")

			if(version != @spec.builtin_protocol_version)
				Wired::Log.error "Handshake Failed: Local version is #{version} but remote version is #{@spec.builtin_protocol_version}"
				return false
			end

			# get protocol name
			@remote_name = message.parameter("p7.handshake.protocol.name")
			if(!@remote_name)
				Wired::Log.error "Message has no 'p7.handshake.protocol.name' field"
				return false
			end

			# get protocol version
			@remote_version = message.parameter("p7.handshake.protocol.version")
			if(!@remote_version)
				Wired::Log.error "Message has no 'p7.handshake.protocol.version' field"
				return false
			end

			@local_compatibility_check = !@spec.is_compatible_with_protocol(@remote_name, @remote_version)

			# get socket options
			if(@serialization == Wired::Socket::Serialization::BINARY)
				if(message.parameter("p7.handshake.compression") == 0)
					@compression_enabled = true
				end

				if(message.parameter("p7.handshake.encryption") != nil)
					@cipher = message.parameter("p7.handshake.encryption").to_i
				end
			end

			puts "@compression_enabled : #{@compression_enabled}"

			if(message.parameter("p7.handshake.compatibility_check") == false)
				@remote_compatibility_check = false 
			end

			# acknowledge handshake
			message = Wired::Message.new(:spec => @spec, :name => "p7.handshake.acknowledge")
			message.add_parameter("p7.handshake.compatibility_check", true) if @local_compatibility_check
			write message

			return true
		end




		def connect_key_exange(username, password)
			# read the server key
			message = read

			return false if !message

			if message.name != "p7.encryption.server_key" 	
				Wired::Log.error "Message should be 'p7.encryption.server_key', not '#{message.name}'"
			end

			# get the RSA key
			rsa = message.parameter("p7.encryption.public_key")

			if !rsa 	
				Wired::Log.error "Message has no 'p7.encryption.public_key' field"
			end

			# Cretae a new local public key
			@public_key = OpenSSL::PKey::RSA.new(message.parameter("p7.encryption.public_key"))

			return false if !@public_key

			# Create a new local cipher
			@ssl_cipher = Wired::Cipher.new(@cipher)

			return false if !@ssl_cipher

			# Create username and password for authentification
			@username		 			= !@username ? "" : @username	
	    password_sha1	 		= sha1_data(!@password ? "" : @password)
	    client_password1 	= sha1_data(password_sha1 + rsa)
			client_password2 	= sha1_data(rsa << password_sha1)

			return false if !@username
			return false if !password_sha1

			# Send client key and authentification
	    message = Wired::Message.new(:spec => @spec, :name => "p7.encryption.client_key")
	    message.add_parameter("p7.encryption.cipher.key", encrypt_data(@ssl_cipher.cipher_key))
	    message.add_parameter("p7.encryption.cipher.iv", encrypt_data(@ssl_cipher.cipher_iv))	    
	    message.add_parameter("p7.encryption.username", encrypt_data(@username))
	    message.add_parameter("p7.encryption.client_password", encrypt_data(client_password1))

	    message = write_and_read_response message

	    return false if !message

	    if message.name == "p7.encryption.authentication_error"
	    	Wired::Log.error "Authentification failed for #{@username}"
	    	return false
	    end

	    if message.name != "p7.encryption.acknowledge"
	    	Wired::Log.error "Message should be 'p7.encryption.acknowledge', not '#{message.name}'"
	    	return false
	    end

	    encrypted_password = message.parameter("p7.encryption.server_password")

	    if !encrypted_password
	    	Wired::Log.error "Message has no 'p7.encryption.server_password' field"
	    	return false
	    end

	    server_password = @ssl_cipher.decrypt(encrypted_password)

	    if !check_passwords(server_password, client_password2)
	    	Wired::Log.error "Password mismatch during key exchange"
	    	return false
	    end

	    @encryption_enabled = true

			return true
		end



		def check_passwords(password1, password2)
			index = 0
			password2.each_char do |i|
			  	if (i.chr != password1[index])
					return false
				end
				index += 1
			end 

			return true
		end




		def send_compatibilit_check
			message = Wired::Message.new(:spec => @spec, :name => "p7.compatibility_check.specification")
			
			return false if !message

			message.add_parameter("p7.compatibility_check.specification", @spec.doc.to_xml)

			message = write_and_read_response message

			return false if !message

			if message.name != "p7.compatibility_check.status"
				Wired::Log.error "Message should be 'p7.compatibility_check.status', not '#{message.name}'"
				return false
			end

			status =  message.parameter "p7.compatibility_check.status"
			if status == nil
				Wired::Log.error "Message has no 'p7.compatibility_check.status' field"
				return false
			end

			if status == false
				Wired::Log.error "Remote protocol #{@remote_name} #{@remote_version} 
				is not compatible with local protocol #{@spec.protocol_name} #{@spec.protocol_verion}"
			end

			return status
		end



		def handle_message(message) 
			return if !message

			Wired::Log.debug "Received Message: " + message.name
			handle_error message if message.name == "wired.error"
		end




	    def handle_error(message)
	    	Wired::Log.error "Wired Error: " + message.to_s
			@errors.push message
	    end




		def deflate_data(data)
			c_stream 						= Z_stream.new
			c_stream.data_type 	= Z_UNKNOWN

			data_length		 			= data.length
			data 								= Bytef.new(data)

	    compressed_length		= (data.length * 2) + 16
	    compressed_data 		= Bytef.new(0.chr * compressed_length)

	    err = deflateInit(c_stream, Z_DEFAULT_COMPRESSION)
	    if(err != Z_OK)
		    raise RuntimeError,"error: deflateInit #{err}"
		  end

	    c_stream.next_in  	= data
	    c_stream.avail_in 	= data.length
	    c_stream.next_out 	= compressed_data
	    c_stream.avail_out 	= compressed_length

	    err = deflate(c_stream, Z_FINISH)
		  raise RuntimeError,"error: deflate #{err}" if(err != Z_STREAM_END)

		  compressed_data = compressed_data.buffer

	    err = deflateEnd(c_stream)
		  raise RuntimeError,"error: deflateEnd #{err}" if(err != Z_OK)

	    return compressed_data
		end



		def inflate_data(data)
		  #return Zlib::Inflate.inflate(data, Zlib::DEFAULT_COMPRESSION)		  
		end



		def encrypt_data(data)
			return @public_key.public_encrypt(data, RSA_PKCS1_OAEP_PADDING)
		end



		def decrypt_data(data)
			return @public_key.public_decrypt(data, RSA_PKCS1_OAEP_PADDING) # or 0 ?
		end


		def sha1_data(data)
			Digest::SHA1.hexdigest(data)
		end
	end
end