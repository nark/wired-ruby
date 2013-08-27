# == message.rb
# This file contains the Wired::Message class definition. In the Wired
# specification, a message is a peice of XML text designed against the 
# specification file (wired.xml).
#
# == Example
#
#    message = Wired::Message.new("wired.client_info", spec)
#    message.set_value_for_name("Ruby Wired", "wired.info.application.name")
#
# == Contact
#
# Author::  Rafaël Warnault (mailto:dev@read-write.fr)
# Website:: http://wired.read-write.fr
# Date::    Saturday May 29, 2013
#
module Wired
	# This class handles Wired message representation and operations.
	# 
	# For more information about how Wired messages are defined, you are pleased
	# to have a look to the specification of the protocol: 
	# http://www.read-write.fr/wired/html/wired.html
	class Message
		# Requires the Nokogiri XML library
		require 'nokogiri'



		# The name of the message. It acts as a key to identify the message
		attr_accessor	:name

		# The spec against which the message is built (See Wired::Spec class)
		attr_accessor	:spec

		# A XML string containing the message
		attr_accessor 	:xml

		# A Nokogiri::XML::Document object encapsulating the :xml attribute
		attr_accessor	:doc



		# Initialize a message for a given `name` against a given 
		# Wired::Spec object 
		#
		# @param name [String] the message name
		# @param spec [Wired::Spec] the Wired specification object
		#
		# @return A Wired::Message instance
		def initialize(name_or_xml, spec)
			if name_or_xml.start_with?("<?xml version=")
				init_with_xml(name_or_xml, spec)
			else
				init_with_name(name_or_xml, spec)
			end
		end


		def init_with_name(name, spec)
			@name	= name
			@spec	= spec
			@xml 	= spec.message_with_name(name)
			@doc 	= Nokogiri::XML(@xml)
		end


		def init_with_xml(xml, spec)
			@spec	= spec
			@xml 	= xml
			@doc 	= Nokogiri::XML(@xml)
			@name	= get_name_from_xml
		end


		# Returns the value for a field in a Wired::Message object
		#
		# @param name [String] the field name
		#
		# @return A String with the field value or nil
		def value_for_name(name)
			query 	= "//p7:message/p7:field[@name='" + name + "']"
			@doc.xpath(query).map do |field|
				return field.text
			end
			return nil
		end


		# Set the value of a field in a Wired::Message object
		#
		# @param name [String] the field name
		# @param value [Object] the value for this field
		#
		# @return true if value was updated, false if value was not found
		def set_value_for_name(value, name)
			query 	= "//p7:message/p7:field[@name='" + name + "']"
			@doc.xpath(query).map do |field|
				field.content = value
				return true
			end
			return false
		end

		# Returns a string representation of the message in XML format
		def to_s
			return @doc.to_s
		end


	private
		def get_name_from_xml
			query 	= "//p7:message/@name"
			name 	= @doc.xpath(query)

			return name.to_s
		end
	end
end

