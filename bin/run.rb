require_relative '../config/environment'

puts "Hello, welcome to MovieQueueApp™."
puts "Are you a new or existing user?"
puts "Press 1 if you are an existing user or 2 to create a new account:"

user_input = gets.chomp

def user_options(name)
  puts "Welcome #{name}! what would you like to do?
    -type update to update
    -type add to add movie to a list
    -type add list add new list
    -choose a random movie from your queue
    -delete a list" #their own list
end

 input= gets.chomp

 if input == "update"
   #run a method to update
 elsif input == "add"
   #run a method to add
 elsif input == "add list"
 else
   "Incorrect input. Try again."
 end

if user_input == "1"
  puts "Please enter your username"
  name = gets.chomp
  User.all.find_by(name: name)
  user_options(name)
elsif user_input == "2"
  puts "Please enter a new username"
  new_name = gets.chomp
  User.create(name: new_name)
else
  puts "Invalid input. Press 1 if you are an existing user and 2 to create a new account."
end
