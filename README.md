# wired-ruby

## Introduction

Wired-Ruby is a light programming library that implements the Wired 2.0 protocol in Ruby language. This source code is a working base mainly used to better understand the Wired 2.0 protocol specifications. This library is under development and is not ready yet for production.

### Implemented features

* XML-Based Specification for the Wired 2.0 protocol
* Socket communications for the client-side
* Binary serialization of messages
* SSL/TLS encryption of communication

### To-implement features

* Data compression using deflate algorithm
* Message checksum using sha algorithm
* Out-of-band data communication for file transfers

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

		gem build wired.gemspec-0.0.2.gem
		
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

## Contribute

Of course, every contributions are welcome, do not hesitate to commit pull-requests.

## License
	
	Copyright (c) 2013-2015, Rafaël Warnault. All rights reserved.
	
	Redistribution and use in source and binary forms, with or without
	modification, are permitted provided that the following conditions are met:
	
	* Redistributions of source code must retain the above copyright
	  notice, this list of conditions and the following disclaimer.
	* Redistributions in binary form must reproduce the above copyright
	  notice, this list of conditions and the following disclaimer in the
	  documentation and/or other materials provided with the distribution.
	* Neither the name of the University of California, Berkeley nor the
	  names of its contributors may be used to endorse or promote products
	  derived from this software without specific prior written permission.
	
	THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS'' AND ANY
	EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
	WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
	DISCLAIMED. IN NO EVENT SHALL THE REGENTS AND CONTRIBUTORS BE LIABLE FOR ANY
	DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
	(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
	LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
	ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
	(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
	SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
