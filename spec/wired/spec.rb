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
	end
end
