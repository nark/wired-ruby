require File.dirname(__FILE__) + '/../../lib/wired'

module Wired
	describe Client do

		before :each do
			@spec 	= Wired::Spec.new
			@url 	  = Wired::Url.new("wired://localhost")
			@nick	  = "Nark"
			@status = "Testing"
		end

		context "::new" do
			it "should create a new custom Wired Client object" do
				client = Wired::Client.new(
					@spec, 
					:nick 	=> @nick, 
					:status => @status)

				expect(client.nick).to 		eq 	@nick
				expect(client.status).to 	eq 	@status
			end
		end


		context "::connect::encryption_disabled" do
			it "should connect Wired Client object to localhost server" do
				client = Wired::Client.new(
					@spec, 
					:login 				=> "guest",
					:password 		=> "",
					:encryption 	=> Wired::Socket::Cipher::NONE)

				expect(client.connect(@url)).to be_truthy
			end
		end


		context "::connect::encryption_enabled" do
			it "should connect Wired Client object to localhost server" do
				client = Wired::Client.new(
					@spec, 
					:login 				=> "guest",
					:password 		=> "",
					:encryption 	=> Wired::Socket::Cipher::RSA_AES_256)

				expect(client.connect(@url)).to be_truthy
			end
		end

		context "::connect::compression_enabled" do
			it "should connect Wired Client object to localhost server" do
				client = Wired::Client.new(
					@spec, 
					:login 				=> "guest",
					:password 		=> "",
					:compression 	=> Wired::Socket::Compression::DEFLATE)

				expect(client.connect(@url)).to be_truthy
			end
		end
	end
end