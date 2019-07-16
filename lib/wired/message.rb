module Wired
	# The Message class reprensents a Wired message. It uses its
	# object structure to store message data, regarless to the 
	# serialization mode. A message object can be created from 
	# XML or Binary data, and can be represented 
	# This file contains the Wired::Message class definition.
	#
	#
	# @example Create a message against the specification and add a parameter
	# 	spec = Wired::Spec.new("wired.xml")
	#
	# 	message = Wired::Message.new(:spec => spec, :name => "p7.handshake.client_handshake")
	# 	message.add_parameter("p7.handshake.version", "2.0")
	#
	#
	# @example Print the message as XML
	# 	puts message.to_xml
	#
	# 	=>
	# 
	# 	<?xml version="1.0" encoding="UTF-8"?>
	# 	<p7:message xmlns:p7="http://www.zankasoftware.com/P7/Message" name="p7.handshake.client_handshake">
	#     <p7:field name="p7.handshake.version">2.0</p7:field>
	# 	</p7:message>
	#
	#
	# @example Print the message as Binary
	# 	puts message.to_bin.unpack("H*")[0].to_s
	#
	# 	=>
	#
	# 	000000010000000100000004322e3000
	#
	# @author Rafaël Warnault (mailto:dev@read-write.fr)
	#
	class Message
		require 'bindata'


		class ListFieldArray < BinData::Record
			int32be :field_id
			stringz :field_length
		end



		class Data < BinData::Primitive
		  uint8  :len,  :value => lambda { data.length }
		  string :data, :read_length => :len

		  def get;   self.data; end
		  def set(v) self.data = v; end
		end



		class TypeChoice < BinData::Choice
			bit1 		1,  :read_length => 1 #boolean (1)
			int32be 	2,	:read_length => 4 #enum (4)
			int32be 	3,  :read_length => 4 #int32 (4)
			uint32be 	4,  :read_length => 4 #uint32 (4)
			int64be 	5,  :read_length => 4 #int64 (4)
			uint64be 	6,  :read_length => 4 #uint64 (4)
			double_be 	7,  :read_length => 4 #double (4)
			stringz 	8,  :read_length => :field_length, :trim_padding => true #string (*)
			stringz 	9,  :read_length => 16 #uuid (16)
			string 		10, :read_length => 8 #date (8)
			string 		11, :read_length => :field_length, :trim_padding => true #data (*)
			stringz 	12, :read_length => 8 #oobdata (8)
			array 		13, :type => :list_field_array, :read_until => :eof

			def field_length
				return parent.field_length
			end
		end




		class FieldArray < BinData::Record
			int32be :field_id
			int32be :field_length, :onlyif => :has_length?
			type_choice :data, :selection => :chooser


			def real_parent
				return (parent.kind_of? Wired::Message::MessageData) ? parent : parent.parent
			end

			def chooser
				return self.real_parent.spec.type_id_for_field_id(field_id).to_i
			end

			def has_length?
				choice = self.real_parent.spec.type_id_for_field_id(field_id).to_i
				return (choice == 8 || choice == 11 || choice == 13)
			end
		end




		class MessageData < BinData::Record
			attr_accessor 	:spec

			int32be :message_id
			array :message_fields, :type => :field_array, :read_until => :eof
		end




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
			Wired::Log.error self.class.to_s + ":initilize :spec is required" and return if !args.key?(:spec)

			@id 			= args[:id]
			@name 			= args[:name]
			@spec 			= args[:spec]
			@spec_message 	= args[:spec_message]
			@xml 			= args[:xml] 
			@binary 		= args[:binary] 
			@parameters 	= Hash.new

			return nil if !load_message 
		end


		# Get message parameters
		# 
		# @param name [String] A Wired field name
		#
		# @return [Object] Returns the value of the field for 
		# 	the given name
		def parameter(name) 
			return nil if name == nil
			return @parameters[name]
		end


		# Set a message parameter
		#
		# @param name [String] A Wired field name
		# @param value [Object] The value of the field
		#
		# @return [Boolean] Returns Hash assignent result
		def add_parameter(name, value = nil)
			return false if name == nil
			return @parameters[name] = value
		end


		# Add a set of parameters
		#
		# @param parameters [Hash] A Hash of parameters
		def add_parameters(parameters = {})
			@parameters = @parameters.merge(parameters)
		end


		# XML representation of the message
		#
		# @return [String] XML representation of the message as string
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



		# Binary representation of the message
		#
		# @return [String] Binary representation of the message, as string
		# 	because Ruby uses String to handle binary data.
		def to_bin
			message_data = MessageData.new
			message_data.message_id = @id.to_i
			message_data.spec = @spec
			message_data.message_fields = Array.new

			@parameters.each do |name, value|
				
				spec_field = @spec.spec_field_with_name(name)
				data_field = FieldArray.new(nil, message_data)

				data_field.field_id = spec_field.id.to_i

				if(data_field.has_length?)
					if spec_field.type.name == "string"
						data_field.field_length = value.length+1

					elsif spec_field.type.name == "data"
						data_field.field_length = value.length

					end
				else 
					if spec_field.type.name == "bool"
						value = (value == "true") ? 1 : 0
					else
						data_field.field_length = spec_field.type.size.to_i
					end
				end

				type_choice = TypeChoice.new({:selection => spec_field.type.id.to_i}, data_field)
				type_choice.value = value
				data_field.data = type_choice

				message_data.message_fields.push data_field
			end


			@binary = message_data.to_binary_s
			return @binary
		end



		# Object description of the message
		#
		# @return [String] Object description of the message, as string
		def to_s
			return self.class.to_s + ": {:name =>" + @name + ", :id => " + @id + "} [" + @parameters.to_s + "]"
		end



	private

		def load_message
			if !@spec_message && @xml
				return load_message_for_xml(@xml)

			elsif !@spec_message && @binary
				return load_message_for_binary(@binary)

			elsif !@spec_message && @id
				@spec_message = @spec.spec_message_with_id(@id)
				@name 				= @spec_message.name

			elsif !@spec_message && @name
				@spec_message = @spec.spec_message_with_name(@name)
				@id 					= @spec_message.id
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
			message_data = MessageData.new
			message_data.spec = @spec

			#puts "binary : "+ binary.unpack("H*").to_s

			#BinData::trace_reading do # used to debug bindata gem
				message_data.read(binary)
			#end

			@id 			= message_data.message_id.to_s
  			@spec_message 	= @spec.spec_message_with_id(@id)
  			@name 			= @spec_message.name

			if(@spec_message == nil)
				Wired::Log.error "Unknow message with id: " + @id
				return false
			end

			message_data.message_fields.each do |field|
				@spec_field = @spec.spec_field_with_id(field.field_id.to_s)
				add_parameter(@spec_field.name, field.data)
			end

			return true
		end
	end
end