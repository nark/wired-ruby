module Wired
	class Client
		require 'digest/sha1'

		attr_accessor	:spec
		attr_accessor	:url
		attr_accessor	:nick
		attr_accessor	:status
		attr_accessor	:icon
		attr_accessor	:socket

		attr_accessor	:connected_block
		attr_accessor	:receive_block



		def initialize(spec, nick=nil, status=nil)
			@spec		= spec
			@nick 		= nick  	|| "Ruby Wired Client"
			@status		= status  	|| "Ruby version " + RUBY_VERSION
		end



		def connect(url)
			@url 		= url
			@socket 	= Wired::Socket.new(@url.hostname, @url.port, @spec)

			if @socket.connect && handshake
				client_info
				if login
					#receive_loop
					ping_loop

					return true
				end
			end

			return false
		end



		def disconnect
			@socket.diconnect
		end



		# def join_public_chat
		# 	message = Wired::Message.new("wired.chat.join_chat", @spec)
		# 	message.set_value_for_name(1, "wired.chat.id")

		# 	send_message(message) {
		# 		rmessage = @socket.read
		# 	}
		# end



		def send_message(message, &block)
			@socket.write(message.to_s)

			puts "Sent Message: " + message.name

			if(block)
				response = @socket.read

			 	block.call(response)

			 	receive_message response
			end
		end



		def receive_message(message)
			puts "Received Message: " + message.name

			if message.name == "wired.send_ping"
				send_message Wired::Message.new("wired.send_ping", self.spec)
			end

			message = @socket.read
			receive_message message
		end



		def destroy
			#@receive_thread.join
			@ping_thread.join
		end



	private
		def handshake
			message = Wired::Message.new("p7.handshake.client_handshake", @spec)
			message.set_value_for_name("1.0", "p7.handshake.version")
			message.set_value_for_name("Wired", "p7.handshake.protocol.name")
			message.set_value_for_name("2.0b55", "p7.handshake.protocol.version")

			send_message message
			message = @socket.read

			if !message
				return false
			end

			if (message.name != "p7.handshake.server_handshake")
				puts "ERROR: Unexpected message " + message.name + " from server";
				return false
			end

			send_message Wired::Message.new("p7.handshake.acknowledge", @spec)

			return true
		end



		def client_info
			message = Wired::Message.new("wired.client_info", @spec)
			message.set_value_for_name("Wired Ruby", "wired.info.application.name")
			message.set_value_for_name("0.1", "wired.info.application.version")
			message.set_value_for_name("0", "wired.info.application.build")
			message.set_value_for_name("OSX", "wired.info.os.name")
			message.set_value_for_name("10.8", "wired.info.os.version")
			message.set_value_for_name("x86_64", "wired.info.arch")

			send_message message
			message = @socket.read
		end



		def login
			message = Wired::Message.new("wired.send_login", @spec)
			message.set_value_for_name("guest", "wired.user.login")
			message.set_value_for_name(Digest::SHA1.hexdigest(""), "wired.user.password")

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
					self.send_message Wired::Message.new("wired.send_ping", self.spec)
					sleep 30 
				end
			}
		end
	end
end