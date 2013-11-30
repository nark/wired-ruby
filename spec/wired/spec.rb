require File.dirname(__FILE__) + '/../../lib/wired'

module Wired
	describe Spec do

		before :each do
			@spec_path 			= "wired.xml"
			@message_name 		= "wired.user.ban_user"
		end

		context "::new" do
			it "should create an empty Wired Specification object" do
				spec = Wired::Spec.new(nil)

				spec.should_not				be_nil
				spec.builtindoc.should_not	be_nil
			end

			it "should create a Wired Specification object for Wired 2.0 protocol" do
				spec = Wired::Spec.new(@spec_path)

				spec.should_not				be_nil
				spec.path.should_not		be_nil
				spec.doc.should_not			be_nil
				spec.builtindoc.should_not	be_nil
			end
		end



		context "::message" do
			it "should create a default Wired message as XML snippet for a given name" do
				spec    = Wired::Spec.new(@spec_path)
				xml 	= spec.xml_message_with_name(@message_name)

				spec.should_not				be_nil	
				xml.should_not				be_nil

				puts xml
			end

			it "should create a default Wired message as XML snippet for a given name using builtin spec" do
				spec    = Wired::Spec.new(@spec_path)
				xml 	= spec.xml_message_with_name("p7.handshake.client_handshake")

				spec.should_not				be_nil	
				xml.should_not				be_nil

				puts xml
			end
		end
	end
end
