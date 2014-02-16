module Wired 
	require 'logging'

	# @return [Logging] The logger used internally by the library
	Log 			= Logging.logger(STDOUT)
	Log.level 		= :debug
end