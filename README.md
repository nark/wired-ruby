# wired-ruby

## Introduction

Wired-Ruby is a light programming library that implements the Wired 2.0 protocol in Ruby language. This source code is a working base mainly used to understand better the Wired 2.0 protocol specifications. The library is not finished and does not support the binary serialization yet. Work in progress...

## Install

1. Get sources:

		git clone https://github.com/nark/wired-ruby.git
	
2. Move into cloned directory:

		cd wired-ruby/
		
3. Build the gem:

		gem build wired.gemspec
		
4. Install the gem:

		gem install wired-0.0.1.gem
		
## Getting started

	require "wired"

	spec 	= Wired::Spec.new "wired.xml"
	url		= Wired::Url.new "wired://localhost"
	client 	= Wired::Client.new spec 
	
	client.connect url
	
	message = Wired::Message.new(:name => "wired.chat.join_chat", :spec => spec)
	message.add_parameter("wired.chat.id", 1)
	
	client.send_message(message) {|response|
		puts response.to_s
	}	