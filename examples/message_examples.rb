require 'rubygems'
require 'textmagic-ruby'

puts ' *** Running message examples *** '

username = 'xxx'
token = 'xxx'

client = Textmagic::REST::Client.new username, token

text = 'Hello from Ruby Api Helper'
phones = '999777777'
params = {
    :text => text,
    :phones => phones
}
new_message = client.messages.create(params)

puts new_message.id > 0
puts !new_message.href.nil?
puts !new_message.message_id.nil?
puts !new_message.session_id.nil?

message = client.messages.get(new_message.id)

puts message.id == new_message.id
puts message.text == text

params = {
    :page => 2
}
messages = client.messages.list(params)

puts messages.page == 2
puts messages.page_count > 0
puts messages.resources.kind_of? Array
puts messages.resources.length == 10

params = {
    :search => true,
    :ids => new_message.id
}
messages_search = client.messages.list(params)

puts messages_search.page == 1
puts messages_search.page_count > 0
puts messages_search.resources.kind_of? Array
puts messages_search.resources.length == 1
puts messages_search.resources.first.id == new_message.id

r = client.messages.delete new_message.id
puts r

begin
  message = client.messages.get(new_message.id)
rescue Textmagic::REST::RequestError => err
  puts err.code == 404
end

price = client.messages.price({:text => 'Hello from Ruby Helper', :phones => '19025555555, 16465555555'})

puts price.total > 0
puts price.parts == 1

puts ' *** Finish message examples *** '