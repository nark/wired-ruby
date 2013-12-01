require File.dirname(__FILE__) + '/../../lib/wired'

module Wired
	describe Client do

		before :each do
			@spec 	= Wired::Spec.new("wired.xml")
			@url 	= Wired::Url.new("wired://localhost")
		end

		# context "::new" do
		# 	it "should create a new custom Wired Client object" do
		# 		nick 			= "Nark"
		# 		status 			= "Testing"
		# 		client			= Wired::Client.new(@spec, :nick => nick, :status => status)

		# 		client.nick.should		eql nick
		# 		client.status.should	eql status
		# 	end
		# end


		context "::connect" do
			it "should connect Wired Client object to localhost server" do
				client			= Wired::Client.new(@spec)

				client.connect(@url)
				#client.join_public_chat
			end
		end
	end
end