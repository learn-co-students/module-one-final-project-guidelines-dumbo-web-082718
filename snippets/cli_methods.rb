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

def user_options(name)
  puts "Welcome #{name}! what would you like to do?
  -Type 'add' to add movie to your queue.
  -Type 'remove' to remove a movie from your queue.
  -Type 'random' to choose a random movie from your queue.
  -Type 'all' to see all movies in your queue."
end
