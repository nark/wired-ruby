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
				expect(url).not_to be		nil
			end

			it "should create a Wired URL object from a complete base string" do
				url 							= Wired::Url.new(@base)

				expect(url).not_to be			nil
				expect(url.scheme).not_to be 	nil
				expect(url.login).not_to be 	nil
				expect(url.password).not_to be 	nil
				expect(url.hostname).not_to be 	nil
				expect(url.port).not_to be 		nil
			end

			it "should create a Wired URL object from an incomplete base string" do
				url 						= Wired::Url.new(@base2)

				expect(url).not_to be			nil
				expect(url.scheme).not_to be	nil
				expect(url.login).not_to be		nil
				expect(url.password).not_to be	nil
				expect(url.hostname).not_to be 	nil
				expect(url.port).not_to be		nil
			end
		end

		context "::update" do
			it "should update Wired URL attributes" do
				url 						= Wired::Url.new(@base2)
				url.login 					= "me"
				url.password 				= "passw0rd"
				url.port					= 4875

				expect(url).not_to be 				nil
				expect(url.scheme).not_to be 		nil
				expect(url.login).not_to be 		nil
				expect(url.password).not_to be		""
				expect(url.hostname).not_to be 		nil
				expect(url.port).not_to be 			nil	
			end
		end


		context "::print" do
			it "should print a string representattion of a Wired URI" do
				url 								= Wired::Url.new(@base)

				expect(url).not_to be				nil
				expect(url.to_s).not_to be			nil
				expect(url.to_s).to be_instance_of	String

				puts "Wired URL as string: " + url.to_s
			end
		end
	end
end