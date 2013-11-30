require "wired"

spec 	= Wired::Spec.new "wired.xml"
url		= Wired::Url.new "wired://localhost"
client 	= Wired::Client.new spec 

client.connect url

message = Wired::Message.new(:name => "wired.chat.join_chat", :spec => spec)
message.add_parameter("wired.chat.id", 1)

client.send_message(message) {|response|
	puts response.to_s
}	
