module Wired
	class User
		# @return [Integer] The user identifier
		attr_accessor	:id

		# @return [Boolean] The user identifier
		attr_accessor	:idle

		# @return [String] The user nickname
		attr_accessor	:nick

		# @return [String] The user status
		attr_accessor	:status

		def initialize(message)
			@id 		= message.parameter("wired.user.id")
			@idle 		= message.parameter("wired.user.idle")
			@nick 		= message.parameter("wired.user.nick")
			@status 	= message.parameter("wired.user.status")
		end
	end
end