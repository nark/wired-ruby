module Wired
	class Spec
		require 'nokogiri'

		attr_accessor	:path
		attr_accessor 	:doc
		attr_accessor 	:builtindoc

	public
		def initialize(path)
			@path 				= path
			@doc 				= nil
			
			xml = 
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

			if @path
				load(@path)
			end
		end


		# create a Wired::Message object template against the specification for a given name
		def message_with_name(name)
			spec 	= spec_for_message_name(name)
			fields 	= Array.new
			query 	= "//protocol/messages/message[@name='" + name + "']/parameter"
			builder = Nokogiri::XML::Builder.new(:encoding => 'UTF-8') do |xml|
				parameters = spec.xpath(query).map 

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
								sub_fields = collection_with_name(value)
								sub_fields.each do |sub_param|
									xml["p7"].field("name" => sub_param.attribute_nodes.first.value){ 
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
		    @doc = Nokogiri::XML(file)
		    @doc.remove_namespaces!
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


