# message.rb
# This file contains the Wired::Message class definition.
#
# @example Create a message against the specification
# 	and add a parameter
# 	spec = Wired::Spec.new("wired.xml")
# 	message = Wired::Message.new(:spec => spec, :name => "p7.handshake.client_handshake")
# 	message.add_parameter("p7.handshake.version", "2.0")
#
# @author Rafaël Warnault (mailto:dev@read-write.fr)
#
module Wired
	# The Message class reprensents a Wired message. It uses its
	# object structure to store message data, regarless to the 
	# serialization mode. A message object can be created from 
	# XML or Binary data, and can be represented 
	class Message
		# @return [String] The id of the message
		attr_accessor 	:id

		# @return [String] The name of the message
		attr_accessor 	:name

		# @return [Hash] A has of message parameters. The field name is used as the key.
		attr_accessor 	:parameters

		# @return [Wired::Spec] The attached specification object
		attr_accessor 	:spec

		# @return [Wired::Spec::SpecMessage] The matching spec message
		attr_accessor 	:spec_message

		# @return [String] XML string representation of the message. 
		# 	Used when creating messages based on XML serialization.
		attr_accessor 	:xml

		# @return [String] Binary data representation of the message. 
		# 	Used when creating messages based on Binary serialization.
		attr_accessor 	:binary

		# Initialize a Message object with given arguments.
		# 
		# @param args [Hash] A hash of arguments
		# @option args [String] :id The id of the message (required if no :name)
		# @option args [String] :name The name of the message (required if no :id)
		# @option args [Wired::Spec] :spec The attached specification object (required)
		# @option args [Wired::Spec::SpecMessage] :spec_message The matching spec message
		# @option args [Nokogiri::XML] :xml XML string representation of the message
		# @option args [String] :binary Binary data representation of the message
		#
		# @return [Wired::Message] Returns a Message instance 
		# 	if arguments loading succeded.
		def initialize(args = {}) 
			Wired::LOGGER.error self.class.to_s + ":initilize :spec is required" and return if !args.key?(:spec)

			@id 			= args[:id]
			@name 			= args[:name]
			@spec 			= args[:spec]
			@spec_message 	= args[:spec_message]
			@xml 			= args[:xml] 
			@binary 		= args[:binary] 
			@parameters 	= Hash.new

			return nil if !load_message 
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

				binary << [spec_field.id.to_i].pack("N")
				binary << [value.to_s.length + 1].pack("N")
				binary << [value.to_s].pack("Z*")
			end

			@binary = binary

			return binary
		end


	private

		def load_message
			if !@spec_message && @xml
				return load_message_for_xml(@xml)

			elsif !@spec_message && @binary
				return load_message_for_binary(@binary)

			elsif !@spec_message && @id
				@spec_message 	= @spec.spec_message_with_id(@id)
				@name 			= @spec_message.name

			elsif !@spec_message && @name
				@spec_message 	= @spec.spec_message_with_name(@name)
				@id 			= @spec_message.id
			end
			return true
		end


		def load_message_for_xml(xml)	
			doc		= Nokogiri::XML(xml)
			query	= "//p7:message/@name"

			@name	= doc.xpath(query).to_s

			return false if !@name

			@spec_message = @spec.spec_message_with_name(@name)

			return false if !@spec_message

			@id		= @spec_message.id
			query	= "//p7:message/p7:field/*"

			doc.xpath(query).each do |field|
				name 	= field["name"]
				value 	= field.text

				@parameters[name] = value
			end
			return true
		end


		def load_message_for_binary(binary)	
			length		= binary.length
			buffer, w	= IO.pipe 

			w << binary
			w.close

			begin
				@id 			= buffer.readpartial(Wired::Socket::SOCKET_LENGTH_SIZE).unpack("N")[0].to_s
	  			@spec_message 	= @spec.spec_message_with_id(@id)

				if(@spec_message == nil)
					Wired::LOGGER.error "Unknow message with id: " + @id.to_s
					return false
				end

				@name 		= @spec_message.name
				read_size 	= 0

				while ((read_size < length) && (bin = buffer.readpartial(Wired::Socket::SOCKET_LENGTH_SIZE))) do
					name, value, size = read_binary_field(bin, buffer)

					add_parameter(name, value)

					read_size += (Wired::Socket::SOCKET_LENGTH_SIZE * 2) + size
					break if (read_size > length || (length-read_size) < Wired::Socket::SOCKET_LENGTH_SIZE)
				end
			rescue EOFError
				return false if (!@id || !@spec_message)
			end

			buffer.close
			return true
		end


		def read_binary_field(binary, buffer)
			field_id 	= binary.unpack("N")[0].to_s
			field 		= @spec.spec_field_with_id(field_id)

			if(field == nil)
				Wired::LOGGER.error "Unknow field with id: " + id
				return nil
			end

			size 		= buffer.readpartial(Wired::Socket::SOCKET_LENGTH_SIZE).unpack("N")[0].to_i || 0
			value 		= read_binary_field_value(field, size, buffer)
			name 		= field.name

			return name, value, size
		end




		def read_binary_field_value(field, size, buffer)
			value = buffer.readpartial(size)

			# Wired types: bool, enum, int32, uint32, int64, uint64, double 
			# string, uuid, date, data, oobdata, list
			#
			# <p7:type name="bool" id="1" size="1" />
			# <p7:type name="enum" id="2" size="4" />
			# <p7:type name="int32" id="3" size="4" />
			# <p7:type name="uint32" id="4" size="4" />
			# <p7:type name="int64" id="5" size="8" />
			# <p7:type name="uint64" id="6" size="8" />
			# <p7:type name="double" id="7" size="8" />
			# <p7:type name="string" id="8" />
			# <p7:type name="uuid" id="9" size="16" />
			# <p7:type name="date" id="10" size="8" />
			# <p7:type name="data" id="11" />
			# <p7:type name="oobdata" id="12" size="8" />
			# <p7:type name="list" id="13" />

			case field.type
			when "string"
				value = value.unpack("H" + (size + 2).to_s)[0]
			  	value = [value].pack("H*")
			when "bool"
				value = value.unpack("N")[0]
				value = value.to_i
			when "enum"
				value = value.unpack("N4")[0]
				value = value.to_i
			when "int32"
				value = value.unpack("N4")[0]
				value = value.to_i
			when "uint32"
				value = value.unpack("N4")[0]
			  	value = value.to_i
			when "int64"
				value = value.unpack("N8")[0]
				value = value.to_i
			when "uint64"
				value = value.unpack("N8")[0]
			  	value = value.to_i
			else
			  Wired::LOGGER.error 'Unsupported type:' + field.type
			end

			return value
		end
	end
end