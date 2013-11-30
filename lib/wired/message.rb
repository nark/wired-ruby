module Wired
	class Message
		attr_accessor :id
		attr_accessor :name
		attr_accessor :parameters

		attr_accessor :spec
		attr_accessor :spec_message
		attr_accessor :xml

		def initialize(args = {}) 
			Wired::LOGGER.error self.class.to_s + ":initilize :spec is required" and return if !args.key?(:spec)

			@id 			= args[:id]
			@name 			= args[:name]
			@spec 			= args[:spec]
			@spec_message 	= args[:spec_message]
			@xml 			= args[:xml] 
			@parameters 	= Hash.new

			load_message
		end


		def parameter(name) 
			return nil if name == nil
			return @parameters[name]
		end


		# set a message parameter for a given value
		def add_parameter(name, value = nil)
			return false if name == nil
			return @parameters[name] = value
		end


		def add_parameters(parameters = {})
			@parameters = @parameters.merge(parameters)
		end


		def to_xml
			builder = Nokogiri::XML::Builder.new(:encoding => 'UTF-8') do |xml|
				xml.message("name" => @name, "xmlns:p7" => "http://www.zankasoftware.com/P7/Message") {

					@parameters.each do |name, value|
						xml["p7"].field("name" => name){ 
							xml.text (value) ? value : ""
						}
					end
				}
			end

			builder.doc.root.name = "p7:message"
			xml = builder.to_xml

			return xml
		end


		def to_s
			return self.class.to_s + ": {:name =>" + @name + ", :id => " + @id + "} [" + @parameters.to_s + "]"
		end


		def to_bin
			binary = [@id.to_i].pack("N*")

			@parameters.each do |name, value|
				spec_field = @spec.spec_field_with_name(name)

				binary += [spec_field.id.to_i].pack("N*")
				binary += [value.bytes.length].pack("N*")
				binary += [value.to_s.encode('utf-8')].pack("Z*")
			end

			return binary
		end


	private

		def load_message
			if !@spec_message && @id
				@spec_message 	= @spec.spec_message_with_id(@id)
				@name 			= @spec_message.name

			elsif !@spec_message && @name
				@spec_message 	= @spec.spec_message_with_name(@name)
				@id 			= @spec_message.id

			elsif !@spec_message && @xml
				load_message_for_xml(@xml)
			end
		end


		def load_message_for_xml(xml)	
			doc 			= Nokogiri::XML(xml)
			query 			= "//p7:message/@name"

			@name 			= doc.xpath(query).to_s
			@spec_message 	= @spec.spec_message_with_name(@name)
			@id 			= @spec_message.id

			query 			= "//p7:message/p7:field/*"

			doc.xpath(query).each do |field|
				name 	= field["name"]
				value 	= field.text

				@parameters[name] = value
			end
		end
	end
end