module Wired
	class Topic
		attr_accessor	:topic
		attr_accessor	:nick
		attr_accessor	:time

		def initialize(message)
			@nick 		= message.parameter("wired.user.nick")
			@topic 		= message.parameter("wired.chat.topic.topic")
			@time		 	= message.parameter("wired.chat.topic.time")
		end
	end
end