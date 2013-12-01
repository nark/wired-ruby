require "wired"

# Create a Wired Spec object based on "wired.xml" file
spec = Wired::Spec.new "wired.xml"

# Create a Wired Url object pointing to "localhost"
url = Wired::Url.new "wired://localhost"

# Create a Client object against the specification
client = Wired::Client.new spec 

# Connect the client to the url
client.connect url

# Create a "wired.chat.join_chat" message to join the public chat
message = Wired::Message.new(:name => "wired.chat.join_chat", :spec => spec)
message.add_parameter("wired.chat.id", 1)

# Send the message through the client and print the response
client.send_message(message) {|response|
	puts response.to_s
}