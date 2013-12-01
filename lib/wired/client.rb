module Wired
	class Client
		require 'digest/sha1'

		attr_accessor	:spec
		attr_accessor	:url
		attr_accessor	:nick
		attr_accessor	:status
		attr_accessor	:options
		attr_accessor	:icon
		attr_accessor	:socket

		attr_accessor	:connected_block
		attr_accessor	:receive_block




		def initialize(spec, options = {})
			@spec		= spec
			@nick 		= options[:nick]  	|| "Ruby Wired Client"
			@status		= options[:status]  || "Ruby version " + RUBY_VERSION
			@options 	= options
		end




		def connect(url)
			@url 		= url
			options 	= {
				:port 		 	=> @url.port,
				:timeout 		=> @options[:timeout],
				:serialization 	=> Wired::Socket::Serialization::BINARY,
				:cipher 		=> Wired::Socket::Cipher::NONE,
				:compression 	=> Wired::Socket::Compression::NONE
			}

			@socket = Wired::Socket.new(@url.hostname, @spec, options)

			if @socket.connect
				client_info
				if login
					ping_loop

					return true
				end
			end

			return false
		end




		def disconnect
			@socket.diconnect
		end




		def send_message(message, &block)
			@socket.write message

			#Wired::LOGGER.debug "Sent Message: " + message.to_xml

			if(block)
				response = @socket.read

			 	block.call(response)

			 	receive_message response
			end
		end



		def receive_message(message)
			#Wired::LOGGER.debug "Received Message: " + message.to_xml

			if message.name == "wired.send_ping"
				send_message Wired::Message.new(:spec => @spec, :name => "wired.send_ping")
			end

			message = @socket.read
			receive_message message
		end



		def destroy
			#@receive_thread.join
			@ping_thread.join
		end



	private

		def client_info
			message = Wired::Message.new(:spec => @spec, :name => "wired.client_info")

			message.add_parameters({
					"wired.info.application.name" 		=> "Wired Ruby",
					"wired.info.application.version" 	=> "0.1",
					"wired.info.application.build" 		=> "0",
					"wired.info.os.name" 				=> "OSX",
					"wired.info.os.version" 			=> "10.8",
					"wired.info.arch" 					=> "x86_64",
					"wired.info.supports_rsrc" 			=> "false"
				})

			send_message message
			message = @socket.read
		end




		def login
			message = Wired::Message.new(:spec => @spec, :name => "wired.send_login")

			if @url.login && @url.login.size > 0
				message.add_parameter("wired.user.login", @url.login)
			else
				message.add_parameter("wired.user.login", "guest")
			end
			
			if @url.password && @url.password.size > 0
				message.add_parameter("wired.user.password", Digest::SHA1.hexdigest(@url.password))
			else
				message.add_parameter("wired.user.password", Digest::SHA1.hexdigest(""))
			end

			send_message message
			message = @socket.read
		end




		def receive_loop
			@receive_thread = Thread.new(self) {
				while (message = self.socket.read)
					if message
						self.receive_message message
					end
				end
			}
		end




		def ping_loop
			@ping_thread = Thread.new(self) {
				while (message = self.socket.read)
					self.send_message Wired::Message.new(:spec => @spec, :name => "wired.send_ping")
					sleep 30 
				end
			}
		end
	end
end