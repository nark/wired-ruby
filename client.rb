require "wired"

spec 	= Wired::Spec.new "wired.xml"
url		= Wired::Url.new "wired://localhost"
client 	= Wired::Client.new spec 

client.connect url

message = Wired::Message.new("wired.chat.join_chat", spec)
message.set_value_for_name(1, "wired.chat.id")

client.send_message(message) {|response|
	#puts response.to_s
}	
