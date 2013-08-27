require File.dirname(__FILE__) + '/../../lib/wired'

module Wired
	describe Message do

		before :each do
			@spec 			= Wired::Spec.new("wired.xml")
			@message_name 	= "wired.client_info"
			@message_field	= "wired.info.application.name"
			@field_value 	= "Ruby Wired"
		end 


		context "::new" do
			it "should create a new message" do
				message = Wired::Message.new(@message_name, @spec)
			end
		end


		context "::values" do
			it "should add a message field value" do
				message = Wired::Message.new(@message_name, @spec)

				message.set_value_for_name(@field_value, @message_field)
				message.value_for_name(@message_field).should eql @field_value
			end
		end
	end
end