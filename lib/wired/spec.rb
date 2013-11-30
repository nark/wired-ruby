module Wired
	class SpecItem
		attr_accessor	:name
		attr_accessor	:id
		attr_accessor	:version
		attr_accessor	:document

		def initialize(name, options = {})
			@name 		= name
			@id	 		= options[:id]
			@version	= options[:version]
			@document	= options[:document]
		end
	end




	class SpecType < SpecItem
		attr_accessor	:size

		def initialize(name, options = {})
			@size 	= options[:size]
			super
		end
	end




	class SpecField < SpecItem
		attr_accessor	:type
		attr_accessor	:required

		def initialize(name, options = {})
			@type 		= options[:type]
			@required 	= options[:required]
			super
		end
	end




	class SpecCollection < SpecItem
		attr_accessor	:fields

		def initialize(name, options = {})
			@fields 	= options[:fields]
			super
		end
	end




	class SpecMessage < SpecCollection
		def initialize(name, options = {})
			@fields	   = options[:fields]
			super
		end

	end




	class SpecTransaction < SpecItem
		
	end




	class Spec
		require 'nokogiri'
		require 'deep_clone'

		attr_accessor	:path
		attr_accessor 	:doc
		attr_accessor 	:builtindoc

		attr_accessor	:types
		attr_accessor	:fields_by_id
		attr_accessor	:fields_by_name
		attr_accessor	:collections
		attr_accessor	:messages_by_id
		attr_accessor	:messages_by_name
		attr_accessor	:transactions

	public
		def initialize(path)
			@types 				= Hash.new
			@fields_by_id 		= Hash.new
			@fields_by_name		= Hash.new
			@collections 		= Hash.new
			@messages_by_id 	= Hash.new
			@messages_by_name 	= Hash.new
			@transactions 		= Hash.new

			@path 				= path
			@doc 				= nil
			xml 				= 
'<?xml version="1.0" encoding="UTF-8"?>
<p7:protocol xmlns:p7="http://www.zankasoftware.com/P7/Specification"
			 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
			 xsi:schemaLocation="http://www.read-write.fr/wired/html/p7-specification.xsd"
			 name="P7" 
			 version="1.0">

	<p7:types>
		<p7:type name="bool" id="1" size="1" />
		<p7:type name="enum" id="2" size="4" />
		<p7:type name="int32" id="3" size="4" />
		<p7:type name="uint32" id="4" size="4" />
		<p7:type name="int64" id="5" size="8" />
		<p7:type name="uint64" id="6" size="8" />
		<p7:type name="double" id="7" size="8" />
		<p7:type name="string" id="8" />
		<p7:type name="uuid" id="9" size="16" />
		<p7:type name="date" id="10" size="8" />
		<p7:type name="data" id="11" />
		<p7:type name="oobdata" id="12" size="8" />
		<p7:type name="list" id="13" />
	</p7:types>

	<p7:fields>
		<p7:field name="p7.handshake.version" type="string" id="1" />
		<p7:field name="p7.handshake.protocol.name" type="string" id="2" />
		<p7:field name="p7.handshake.protocol.version" type="string" id="3" />
		<p7:field name="p7.handshake.compression" type="enum" id="4">
			<p7:enum name="p7.handshake.compression.deflate" value="0" />
		</p7:field>
		<p7:field name="p7.handshake.encryption" type="enum" id="5">
			<p7:enum name="p7.handshake.encryption.rsa_aes128_sha1" value="0" />
			<p7:enum name="p7.handshake.encryption.rsa_aes192_sha1" value="1" />
			<p7:enum name="p7.handshake.encryption.rsa_aes256_sha1" value="2" />
			<p7:enum name="p7.handshake.encryption.rsa_bf128_sha1" value="3" />
			<p7:enum name="p7.handshake.encryption.rsa_3des192_sha1" value="4" />
		</p7:field>
		<p7:field name="p7.handshake.checksum" type="enum" id="6">
			<p7:enum name="p7.handshake.checksum.sha1" value="0" />
		</p7:field>
		<p7:field name="p7.handshake.compatibility_check" type="bool" id="7" />

		<p7:field name="p7.encryption.public_key" id="9" type="data" />
		<p7:field name="p7.encryption.cipher.key" id="10" type="data" />
		<p7:field name="p7.encryption.cipher.iv" id="11" type="data" />
		<p7:field name="p7.encryption.username" id="12" type="data" />
		<p7:field name="p7.encryption.client_password" id="13" type="data" />
		<p7:field name="p7.encryption.server_password" id="14" type="data" />

		<p7:field name="p7.compatibility_check.specification" id="15" type="string" />
		<p7:field name="p7.compatibility_check.status" id="16" type="bool" />
	</p7:fields>

	<p7:messages>
		<p7:message name="p7.handshake.client_handshake" id="1">
			<p7:parameter field="p7.handshake.version" use="required" />
			<p7:parameter field="p7.handshake.protocol.name" use="required" />
			<p7:parameter field="p7.handshake.protocol.version" use="required" />
			<p7:parameter field="p7.handshake.encryption" />
			<p7:parameter field="p7.handshake.compression" />
			<p7:parameter field="p7.handshake.checksum" />
		</p7:message>

		<p7:message name="p7.handshake.server_handshake" id="2">
			<p7:parameter field="p7.handshake.version" use="required" />
		<p7:parameter field="p7.handshake.protocol.name" use="required" />
			<p7:parameter field="p7.handshake.protocol.version" use="required" />
			<p7:parameter field="p7.handshake.encryption" />
			<p7:parameter field="p7.handshake.compression" />
			<p7:parameter field="p7.handshake.checksum" />
			<p7:parameter field="p7.handshake.compatibility_check" />
		</p7:message>

		<p7:message name="p7.handshake.acknowledge" id="3">
			<p7:parameter field="p7.handshake.compatibility_check" />
		</p7:message>

		<p7:message name="p7.encryption.server_key" id="4">
			<p7:parameter field="p7.encryption.public_key" use="required" />
		</p7:message>

		<p7:message name="p7.encryption.client_key" id="5">
			<p7:parameter field="p7.encryption.cipher.key" use="required" />
			<p7:parameter field="p7.encryption.cipher.iv" />
			<p7:parameter field="p7.encryption.username" use="required" />
			<p7:parameter field="p7.encryption.client_password" use="required" />
		</p7:message>

		<p7:message name="p7.encryption.acknowledge" id="6">
			<p7:parameter field="p7.encryption.server_password" use="required" />
		</p7:message>

		<p7:message name="p7.encryption.authentication_error" id="7" />

		<p7:message name="p7.compatibility_check.specification" id="8">
			<p7:parameter field="p7.compatibility_check.specification" use="required" />
		</p7:message>
		
		<p7:message name="p7.compatibility_check.status" id="9">
			<p7:parameter field="p7.compatibility_check.status" use="required" />
		</p7:message>
	</p7:messages>

	<p7:transactions>
		<p7:transaction message="p7.handshake.client_handshake" originator="client" use="required">
			<p7:reply message="p7.handshake.server_handshake" count="1" use="required" />
		</p7:transaction>

		<p7:transaction message="p7.handshake.server_handshake" originator="server" use="required">
			<p7:reply message="p7.handshake.acknowledge" count="1" use="required" />
		</p7:transaction>

		<p7:transaction message="p7.encryption.server_key" originator="server" use="required">
			<p7:reply message="p7.encryption.client_key" count="1" use="required" />
		</p7:transaction>

		<p7:transaction message="p7.encryption.client_key" originator="client" use="required">
			<p7:or>
				<p7:reply message="p7.encryption.acknowledge" count="1" use="required" />
				<p7:reply message="p7.encryption.authentication_error" count="1" use="required" />
			</p7:or>
		</p7:transaction>

		<p7:transaction message="p7.compatibility_check.specification" originator="both" use="required">
			<p7:reply message="p7.compatibility_check.status" count="1" use="required" />
		</p7:transaction>
	</p7:transactions>
</p7:protocol>'

			
			@builtindoc = Nokogiri::XML(xml)
			@builtindoc.remove_namespaces!

			load_types 			@builtindoc
			load_fields 		@builtindoc
			load_messages 		@builtindoc

			if @path
				load(@path)
			end
		end



		def spec_message_with_name(name)
			return @messages_by_name[name]
		end

		def spec_message_with_id(id)
			return @messages_by_id[id]
		end

		def spec_collection_with_name(name)
			return @collections[name]
		end

		def spec_field_with_name(name)
			return @fields_by_name[name]
		end

		def spec_field_with_id(id)
			return @fields_by_id[id]
		end


		# create a XML message template against the specification for a given name
		def xml_message_with_name(name)
			spec_message 	= @messages_by_name[name]
			query 			= "//protocol/messages/message[@name='" + name + "']/parameter"

			builder = Nokogiri::XML::Builder.new(:encoding => 'UTF-8') do |xml|
				parameters = spec_message.document.xpath(query).map 

				if parameters
					xml.message("name" => name, "xmlns:p7" => "http://www.zankasoftware.com/P7/Message") {
						parameters.each do |parameter|	
							type  = parameter.attribute_nodes.first.name
							value = parameter.attribute_nodes.first.value
							if(type == "field")
								xml["p7"].field("name" => value){ 
									xml.text ""
								}
							elsif(type == "collection")
								collection = @collections[value]
								collection.fields.each do |field_name|
									xml["p7"].field("name" => field_name){ 
										xml.text ""
									}
								end
							end
						end
					}
				end
			end

			builder.doc.root.name = "p7:message"
			return builder.to_xml
		end


		# create a XML message template against the specification for a given id
		def xml_message_with_id(id)
			spec_message 	= @messages_by_id[id]
			query 			= "//protocol/messages/message[@name='" + name + "']/parameter"

			builder = Nokogiri::XML::Builder.new(:encoding => 'UTF-8') do |xml|
				parameters = spec_message.document.xpath(query).map 

				if parameters
					xml.message("name" => spec_message.name, "xmlns:p7" => "http://www.zankasoftware.com/P7/Message") {
						parameters.each do |parameter|	
							type  = parameter.attribute_nodes.first.name
							value = parameter.attribute_nodes.first.value
							if(type == "field")
								xml["p7"].field("name" => value){ 
									xml.text ""
								}
							elsif(type == "collection")
								collection = @collections[value]
								collection.fields.each do |field_name|
									xml["p7"].field("name" => field_name){ 
										xml.text ""
									}
								end
							end
						end
					}
				end
			end

			builder.doc.root.name = "p7:message"
			return builder.to_xml
		end



		# verify a message against the specification
		def verify_message(message)
			
		end




	private
		# loads a specification at path
		def load(path)
		    begin
		      file = File.new(path)
		    rescue
		      puts "ERROR: Can't open the specification file: " + path
		      return
		    end

		    # load the XML document
		    @doc = Nokogiri::XML(file)
		    @doc.remove_namespaces! 
		    # NOTE: namespaces are ignored

		    # load spec items
			load_fields 		@doc
			load_collections 	@doc
			load_messages 		@doc
		end



		def load_types(doc)
			query = "//protocol/types/*"

			doc.xpath(query).each do |node|
				id 		= node["id"]
				type 	= SpecType.new( node["name"], :id => id, :size => node["size"], :document => doc )

				@types[id] = type unless @types.key?(id)
			end
		end



		def load_fields(doc)
			query = "//protocol/fields/*"

			doc.xpath(query).each do |node|
				id 		= node["id"]
				name 	= node["name"]

				field 	= SpecField.new( name, :id => id, :type => node["type"], :version => node["version"], :document => doc )

				@fields_by_id[id] 		= field #unless @fields_by_id.key?(id)
				@fields_by_name[name] 	= field #unless @fields_by_name.key?(name)
			end
		end



		def load_collections(doc)
			fields 	= Array.new
			query 	= "//protocol/collections/*"

			doc.xpath(query).each do |node|
				name = node["name"]

				if ! @collections.key?(name)
					collection 	= SpecCollection.new( name, :document => doc )

					node.children.each do |member|
						field_name = member["field"]
						fields.push field_name unless field_name == nil
					end

					collection.fields 	= fields
					@collections[name] 	= collection
				end
			end
		end



		def load_messages(doc)
			fields 	= Array.new
			query 	= "//protocol/messages/*"

			doc.xpath(query).each do |node|
				id 		= node["id"]
				name 	= node["name"]

				if ! @messages_by_id.key?(id)
					message = SpecMessage.new( name, :id => id, :version => node["version"], :document => doc )

					# search for messages fields and collections
					node.children.each do |subnode|
						break unless subnode != nil

						if(subnode["field"] != nil)
							subname = subnode["field"]

							if (subname != nil)
								field = @fields_by_name[subname]
								field = DeepClone.clone(field)

								field.required = (subnode["use"] == "required")

								fields.push field
							end
						elsif (subnode["collection"] != nil)
							subname 		= subnode["collection"]
							collection 	= @collections[subname]

							collection.fields.each do |field_name|
								field = @fields_by_name[field_name]
								field = DeepClone.clone(field)

								field.required = (subnode["use"] == "required")

								fields.push field
							end
						end
					end

					message.fields 			= fields

					@messages_by_id[id] 	= message
					@messages_by_name[name] = message
				end
			end
		end



		def load_transactions(doc)

		end


		# returns an array of fields for a collection with a given name
		def collection_with_name(name) 
			query = "//protocol/collections/collection[@name='" + name + "']/member"
			return @doc.xpath(query).map
		end



		# returns a Nokogiri::XML::Document object for the given message name
		def spec_for_message_name(name) 
			#puts @builtin_spec
			if name.start_with?('p7.')
				return @builtindoc
			else
				return @doc
			end
		end
	end
end


