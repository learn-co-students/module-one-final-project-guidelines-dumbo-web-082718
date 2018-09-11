def introduction
  puts "Hello, welcome to MovieQueueApp™."
  puts "Are you a new or existing user?"
  puts "Type '1' if you're an existing user or '2' to create a new account:"
end

def option_one
  puts "Please enter your username"
  name = gets.chomp
  User.all.find_by(name: name)
  user_options(name)
end

def option_two
  puts "Please enter a new username"
  new_name = gets.chomp
  User.create(name: new_name)
end

puts "Invalid input. Press 1 if you are an existing user and 2 to create a new account."


def user_options(name)
  puts "Welcome #{name}! what would you like to do?
  -Type 'update' to update
  -type add to add movie to a list
  -type add list add new list
  -choose a random movie from your queue
  -delete a list" #their own list
end
