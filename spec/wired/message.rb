require File.dirname(__FILE__) + '/../../lib/wired'

module Wired
	describe Message do
		before :each do
			@spec = Wired::Spec.new("wired.xml")
		end

		context "::new" do
			it "should create a new spec" do
				@message = Wired::Message.new(:spec => @spec, :name => "p7.handshake.client_handshake")
				@message.add_parameter("p7.handshake.version", "2.0")
			end
		end
	end
end
