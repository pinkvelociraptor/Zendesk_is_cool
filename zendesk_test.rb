require 'zendesk'

account = 'pinkvelociraptor'
username = 'ndellofa@gmail.com'
password = 'webscale'

time = Time.now.to_i
email = "wombato-#{time}@example.com"
name = "Wombat"
client = Zendesk.new(account, username, password)

begin
  user_id = client.create_user(email, name)
  puts "user id #{user_id} created"
rescue Exception => e
  puts "error on creating user #{e}"
  exit 0
end

begin
  description = "Danish people are awesome!!! :)"
  ticket_id = client.create_ticket_for(user_id, description)
  puts "ticket id #{ticket_id} created"
rescue Exception => e
  puts "error on creating ticket #{e}"
  exit 0
end

begin 
  #client.solve_ticket!(ticket_id) # optional comment
  client.solve_ticket!(ticket_id, "Roadhouse!!!!")
  puts "Ticket totally solved. Go ZENDESK!"
rescue Exception => e
  puts "error on solving ticket #{e}"
  exit 0
end

puts "all your ticket are belong to us"
