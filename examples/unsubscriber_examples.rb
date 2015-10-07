require 'rubygems'
require 'textmagic-ruby'

puts ' *** Running unsubscriber examples *** '

username = 'xxx'
token = 'xxx'

client = Textmagic::REST::Client.new username, token

unsubscribers = client.unsubscribers.list

puts unsubscribers.page > 0
puts unsubscribers.limit == 10
puts unsubscribers.page_count > 0
puts unsubscribers.resources.length > 0
puts unsubscribers.resources.first.instance_of?(Textmagic::REST::Unsubscriber)

unsubscribers = client.unsubscribers.list(:search => true)

puts unsubscribers.page > 0
puts unsubscribers.limit == 10
puts unsubscribers.page_count > 0
puts unsubscribers.resources.length > 0
puts unsubscribers.resources.first.instance_of?(Textmagic::REST::Unsubscriber)

u_phone = '999000101010'
u_new = client.unsubscribers.create(:phone => u_phone)

puts !u_new.id.nil?
puts !u_new.href.nil?

unsubscriber = client.unsubscribers.get(u_new.id)

puts unsubscriber.id == u_new.id
puts unsubscriber.phone == u_phone

begin
  client.unsubscribers.update(1, {})
rescue RuntimeError => err
  puts err.message == '`update` method is not available for this type of resource.'
end

begin
    client.unsubscribers.delete(1)
rescue RuntimeError => err
    puts err.message == '`delete` method is not available for this type of resource.'
end

puts ' *** Finish unsubscriber examples *** '