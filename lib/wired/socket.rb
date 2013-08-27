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

		attr_accessor :hostname
		attr_accessor :port
		attr_accessor :spec

		def initialize(hostname, port, spec)
			@hostname 	= hostname
     	 	@port 		= port
     	 	@spec		= spec
     	 	@socket 	= nil
		end


		def connect
			@socket = TCPSocket.new @hostname, @port
		end


		def diconnect
			@socket.close
		end


		def read
			message = ""

			while line = @socket.gets 
				if line == "\r\n"
					break
				end
			  	message = message + line
			end

			if message.length > 0
				message = Wired::Message.new(message, @spec)
				if message.name != "wired.error"
					return message
				else
					puts "Received Wired error: " + message.to_s
				end
			end

			return nil
		end


		def write(xml)
			@socket.write xml+"\r\n"
		end


		def closed?
			return @socket.closed?
		end


	private
		def next_line_readable?
	      readfds, writefds, exceptfds = select([@socket], nil, nil, 0.1)
	      p :r => readfds, :w => writefds, :e => exceptfds
	      readfds #Will be nil if next line cannot be read
	    end
	end
end