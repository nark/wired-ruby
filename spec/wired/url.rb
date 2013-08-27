require File.dirname(__FILE__) + '/../../lib/wired'

module Wired
	describe Url do

		before :each do
			@base 	= "wired://user:password@example.org:4871"
			@base2 	= "wired://example.org"
		end

		context "::new" do
			it "should create an empty Wired URL object" do
				url 						= Wired::Url.new(nil)
				url.should_not 				be_nil
			end

			it "should create a Wired URL object from a complete base string" do
				url 						= Wired::Url.new(@base)

				url.should_not 				be_nil
				url.scheme.should_not 		be_nil
				url.login.should_not 		be_nil
				url.password.should_not 	be_nil
				url.hostname.should_not 	be_nil
				url.port.should_not 		be_nil
			end

			it "should create a Wired URL object from an incomplete base string" do
				url 						= Wired::Url.new(@base2)

				url.should_not 				be_nil
				url.scheme.should_not 		be_nil
				url.login.should_not 		be_nil
				url.password.should 		be_nil
				url.hostname.should_not 	be_nil
				url.port.should_not 		be_nil
			end
		end

		context "::update" do
			it "should update Wired URL attributes" do
				url 						= Wired::Url.new(@base2)
				url.login 					= "me"
				url.password 				= "passw0rd"
				url.port					= 4875

				url.should_not 				be_nil
				url.scheme.should_not 		be_nil
				url.login.should_not 		be_nil
				url.password.should_not 	be_nil
				url.hostname.should_not 	be_nil
				url.port.should_not 		be_nil	
			end
		end


		context "::print" do
			it "should print a string representattion of a Wired URI" do
				url 						= Wired::Url.new(@base)

				url.should_not 				be_nil

				url.to_s.should_not			be_nil
				url.to_s.class.should 		eql String

				puts "Wired URL as string: " + url.to_s
			end
		end
	end
end