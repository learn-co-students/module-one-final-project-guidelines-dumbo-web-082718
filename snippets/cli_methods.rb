def introduction
  puts "Hello, welcome to MovieQueueApp™."
end

def option_one
  puts "Please enter your username:"
  name = gets.chomp.downcase
  User.all.find_by(name: name)
end

def option_two
  puts "Please enter a new username:"
  name = gets.chomp.downcase
  User.create(name: name)
end

def options
  options = {
    add: "ADD MOVIE TO YOUR QUEUE", remove: "REMOVE A MOVIE FROM YOUR QUEUE",
    random: "SELECT A RANDOM MOVIE FROM YOUR QUEUE", all: "SEE ALL MOVIES IN YOUR QUEUE",
    genre: "SEE ALL MOVIES IN YOUR QUEUE BY GENRE", movies: "SHOW ALL MOVIES IN DATABASE",
    quit: "QUIT"
  }
end
