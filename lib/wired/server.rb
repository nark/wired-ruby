

module Wired
	class Server
		attr_accessor :application_name
		attr_accessor :application_version
		attr_accessor :application_build

		attr_accessor :os_name
		attr_accessor :os_version
		attr_accessor :arch
		attr_accessor :supports_rsrc

		attr_accessor :name
		attr_accessor :description
		attr_accessor :banner
		attr_accessor :start_time

		attr_accessor :files_count
		attr_accessor :files_size

		attr_accessor :downloads
		attr_accessor :uploads
		attr_accessor :download_speed
		attr_accessor :upload_speed


		def initialize(message)
			@application_name 		= message.parameter("wired.info.application.name")
			@application_version	= message.parameter("wired.info.application.version")
			@application_build 		= message.parameter("wired.info.application.build")

			@os_name 							= message.parameter("wired.info.os.name")
			@os_version 					= message.parameter("wired.info.os.version")
			@arch 								= message.parameter("wired.info.arch")
			@supports_rsrc 				= message.parameter("wired.info.supports_rsrc")

			@name 								= message.parameter("wired.info.name")
			@description 					= message.parameter("wired.info.description")
			@start_time 					= message.parameter("wired.info.start_time")
			@banner 							= message.parameter("wired.info.banner")
			
			@files_count 					= message.parameter("wired.info.files.count")
			@files_size 					= message.parameter("wired.info.files.size")

			@downloads 						= message.parameter("wired.info.downloads")
			@uploads 							= message.parameter("wired.info.uploads")
			@download_speed				= message.parameter("wired.info.download_speed")
			@upload_speed 				= message.parameter("wired.info.upload_speed")
		end
	end
end