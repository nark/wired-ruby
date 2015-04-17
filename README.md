# wired-ruby

## Introduction

Wired-Ruby is a light programming library that implements the Wired 2.0 protocol in Ruby language. This source code is a working base mainly used to understand better the Wired 2.0 protocol specifications. The library is not finished and does not support the binary serialization yet. Work in progress...

## Dependencies

* nokogiri
* rspec
* timers
* logging
* deep_clone
* openssl
* bindata
* przlib

See `wired.gemspec` files for more details.

## Install

### From sources

1. Get sources:

		git clone https://github.com/nark/wired-ruby.git
	
2. Move into cloned directory:

		cd wired-ruby/
		
3. Build the gem:

		gem build wired.gemspec
		
4. Install the gem:

		gem install wired-0.0.2.gem

### In Your Gemfile

Add the following line to your `Gemfile`

	gem 'wired', github: 'nark/wired-ruby.git'

And run:

	bundle
		
## Getting started

	require "wired"

	# Create a Wired Spec object
	spec = Wired::Spec.new
	
	# Create a Wired Url object
	url = Wired::Url.new "wired://localhost"
	
	# Create a Client object against the specification
	client = Wired::Client.new(spec)
	
	# Connect the client to the url
	exit if !client.connect url
	
	# Create a "wired.chat.say" to post in the public chat	message = Wired::Message.new(:name => "wired.chat.send_say", :spec => spec)
    message.add_parameter("wired.chat.id", 1)
    message.add_parameter("wired.chat.say", content)
	
	# Send the message to the server
	client.send_message(message)
	
	# Wait for the response from the server
	response = client.receive_message

Have a look to `bin/rwire` code, rspec test cases and the source code for more examples.

	
