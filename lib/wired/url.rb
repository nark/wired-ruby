# == url.rb
# This file contains the Wired::Url class definition. Wired URLs use 
# 'wired://' or 'wiredp7://' schemes and handle default informations needed for 
# an user to properly connect to a Wired server: login, password, hostname 
# and port.
#
# == Example
#
#	url				= Wired::Url.new("wired://localhost")
#	url.login		= "username"
#	url.password	= "passw0rd"
#	url.port		= 4875
#
# == Contact
#
# Author::  Rafaël Warnault (mailto:dev@read-write.fr)
# Website:: http://wired.read-write.fr
# Date::    Saturday May 29, 2013
#
module Wired
	require 'uri'

	# This class handles Wired URL representation and operations.
	class Url
		# @return [String] The base string of the URL
		attr_accessor	:base

		# @return [String] The scheme of the URL (wired:// or wiredp7://)
		attr_accessor	:scheme

		# @return [String] The login of the URL
		attr_accessor	:login

		# @return [String] The password of the URL
		attr_accessor	:password

		# @return [String] The hostname of the URL
		attr_accessor	:hostname

		# @return [String] The port of the URL
		attr_accessor	:port


		# Initialize an URL with a given `base` string. This will decompose the 
		# URL string and set local attributes with found values
		#
		# @param base [String] the base string of the URL
		# @option options [String] :hostname The hostname of the URL
		# @option options [String] :login The login of the URL
		# @option options [String] :password The password of the URL
		# @option options [String] :scheme The scheme of the URL (wired:// or wiredp7://)
		# @option options [String] :port The port of the URL
		#
		# @return A Wired::Url instance
		def initialize(base, options = {})
			@base 	= base

			@scheme = "wired" # default scheme

			# decompose the URL if base given
			decompose(base) if base != nil

			# overwrite with options, UNTESTED !
			@hostname 	||= options[:hostname]
			@login 		||= options[:login]
			@password 	||= options[:password]
			@scheme 	||= options[:scheme]
			@port 		||= options[:port]
		end
		
	
		# Returns the String representation of the URL
		#
		# @return A Wired::Url instance
		def to_s
	     	uri = URI::Generic.new(
					@scheme, 
					nil, 
					@hostname, 
					@port, 
					nil, nil, nil, nil, nil)

	     	uri.user 		= @login
	     	uri.password 	= @password
	     	
	     	return uri.to_s
	   end



	private
		# Decomposes a string URL to feed local attributes
		#
		# @param url_string [String] a string URL
		def decompose(url_string)
			uri 		= URI(url_string)
			@hostname 	= uri.host 		|| '127.0.0.1'
			@login 		= uri.user 		|| 'guest'
			@password 	= uri.password 	|| ''
			@scheme 	= uri.scheme	|| 'wired'
			@port 		= uri.port		|| '4871'
		end
	end
end
