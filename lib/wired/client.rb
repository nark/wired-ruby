module Wired
	# The Wired Client class 
	class Client
		require 'digest/sha1'

		attr_accessor	:spec
		attr_accessor	:url
		attr_accessor	:nick
		attr_accessor	:status
		attr_accessor	:options
		attr_accessor	:icon
		attr_accessor	:socket
		attr_accessor :server
		attr_accessor :topic

		attr_accessor	:connected_block
		attr_accessor	:receive_block




		def initialize(spec, options = {})
			@spec				= spec
			@nick 			= options[:nick]  	|| "Ruby Wired Client"
			@status			= options[:status]  || "Ruby version " + RUBY_VERSION
			@icon				= options[:icon] 		|| nil
			@options 		= options
			@listeners  = []
			@users 			= []
		end




		def connect(url, listener = nil)
			@url 		= url
			options = {
				:port 		 			=> @url.port,
				:timeout 				=> @options[:timeout] 			|| 10,
				:serialization 	=> @options[:serialization] || Wired::Socket::Serialization::BINARY,
				:cipher 				=> @options[:cipher] 				|| Wired::Socket::Cipher::RSA_AES_256,
				:compression 		=> @options[:compression] 	|| Wired::Socket::Compression::NONE,
				:username 			=> @options[:username] 			|| url.login,
				:password 			=> @options[:password] 			|| url.password
			}

			@socket = Wired::Socket.new(@url.hostname, @spec, options)
			if @socket.connect
				if client_info and set_user and login
					if listener
						@listeners << listener
						listen

						listeners_print "Connected to #{@server.name}"
						listeners_print ""
					end
					join_chat 1
					return true
				end
			end
			return false
		end




		def disconnect
			@socket.diconnect
		end




		def send_message(message)
			return if !@socket.connected
			@socket.write message
		end




		def receive_message
			return if !@socket.connected
			message = @socket.read
		end



		def join_chat(chat_id)
			listeners_print "## Public Chat User List #############################"

			message = Wired::Message.new(:name => "wired.chat.join_chat", :spec => @spec)
			message.add_parameter("wired.chat.id", chat_id)
			send_message(message)
		end



		def set_nick
			message = Wired::Message.new(:spec => @spec, :name => "wired.user.set_nick")
			message.add_parameter("wired.user.nick", @nick)

			send_message message
			message = @socket.read
		end


		def set_status
			message = Wired::Message.new(:spec => @spec, :name => "wired.user.set_status")
			message.add_parameter("wired.user.status", @status)

			send_message message
			message = @socket.read
		end


		def set_icon
			new_icon = nil

			if @icon != nil 
				new_icon = Wired::Icon.new path: options[:icon] 
			else
				new_icon = Wired::Icon.new string: $default_icon
			end

			Wired::Log.info new_icon.string

			message = Wired::Message.new(:spec => @spec, :name => "wired.user.set_icon")
			message.add_parameter("wired.user.icon", new_icon.to_bin)

			send_message message
			message = @socket.read
		end



	private
		def handle_message(message)
			return unless message
			name = message.name

			case name
				when "wired.send_ping" 
					wired_ping
				when "wired.chat.user_list" 
					wired_chat_user_list message
				when "wired.chat.user_list.done"
					wired_chat_user_list_done message
				when "wired.chat.user_join"
					wired_chat_user_join message
				when "wired.chat.user_leave"
					wired_chat_user_leave message
				when "wired.chat.say"
					wired_chat_say_or_me message
				when "wired.chat.me"
					wired_chat_say_or_me message
				when "wired.chat.topic"
					wired_chat_topic message
			end
		end






		def wired_ping
			self.send_message Wired::Message.new(:spec => spec, :name => "wired.send_ping")
		end


		def wired_chat_user_list(message)
			user = Wired::User.new message
			@users[user.id] = user

			if user.status and user.status.length > 0
				listeners_print "#{user.nick} - #{user.status}"
			else
				listeners_print "#{user.nick}"
			end
		end


		def wired_chat_user_list_done(message)
			listeners_print "######################################################"
		end


		def wired_chat_user_join(message)
			user = Wired::User.new message
			@users[user.id] = user

			now = DateTime.now.strftime("%Y/%m/%d %H:%M")

			listeners_print "#{now} << #{user.nick} joined the chat >>"
		end


		def wired_chat_user_leave(message)
			user_id = message.parameter "wired.user.id"
			return unless user_id

			user = @users[user_id]
			now = DateTime.now.strftime("%Y/%m/%d %H:%M")

			listeners_print "#{now} << #{user.nick} leave the chat >>"

			@users.delete user_id
		end


		def wired_chat_say_or_me(message)
			if message.name == "wired.chat.say" or message.name == "wired.chat.me"
				user_id = message.parameter "wired.user.id"
				return unless user_id

				user = @users[user_id]
				return unless user

				chat_string = message.parameter message.name

				return unless chat_string and chat_string.length > 0

				now = DateTime.now.strftime("%Y/%m/%d %H:%M")

				if message.name == "wired.chat.say"
					listeners_print "#{now} - #{user.nick} : #{chat_string}"

				elsif message.name == "wired.chat.me"
					listeners_print "#{now} - #{user.nick}  #{chat_string}"
				end
			end
		end



		def wired_chat_topic(message)
			has_topic = (@topic == nil) ? false : true

			@topic = Wired::Topic.new(message) if message
			now 		= DateTime.now.strftime("%Y/%m/%d %H:%M")

			if has_topic
				listeners_print "#{now} << #{@topic.nick} changed topic to #{@topic.topic} >>"
			else
				listeners_print "Server Topic : #{@topic.topic} by #{@topic.nick}"
			end
		end




		def listen
		  Thread.new do
		    loop do
		    	message = receive_message
		      handle_message message if message
		    end
		  end
		  @listening = true
		end



		def ping
		  Thread.new do
		    loop do
		    	send_message Wired::Message.new(:spec => @spec, :name => "wired.send_ping")
					sleep 30 
		    end
		  end
		end



		def listening?
		  @listening == true
		end



		def listeners_print(string)
			@listeners.each { |listener| listener.print_message(string) }
		end



		def client_info
			message = Wired::Message.new(:spec => @spec, :name => "wired.client_info")

			message.add_parameters({
				"wired.info.application.name" 		=> "Wired Ruby",
				"wired.info.application.version"  => "0.1",
				"wired.info.application.build" 		=> "1",
				"wired.info.os.name" 							=> "macOS",
				"wired.info.os.version" 					=> "10.8",
				"wired.info.arch" 								=> "x86_64",
				"wired.info.supports_rsrc" 				=> "false"
			})

			send_message message		

			sleep 1

			message = @socket.read

			@server = Wired::Server.new message if message
		end




		def login
			puts "login"

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


		def set_user
			puts "set_user"

			set_nick
			set_status
			set_icon
		end
	end
end