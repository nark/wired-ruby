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

				expect(spec).not_to be				nil
				expect(spec.builtindoc).not_to be	nil
			end

			it "should create a Wired Specification object for Wired 2.0 protocol" do
				spec = Wired::Spec.new(@spec_path)

				expect(spec).not_to be				nil
				expect(spec.path).not_to be			nil
				expect(spec.doc).not_to be			nil
				expect(spec.builtindoc).not_to be	nil
			end
		end
	end
end
