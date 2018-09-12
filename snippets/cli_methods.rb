def introduction
  puts "Hello, welcome to MovieQueueApp™."
end

def get_user_name
  puts "Please enter your username:"
  name = gets.chomp.downcase
  User.all.find_or_create_by(name: name)
end

def options
  options = {
    add: "ADD MOVIE TO YOUR QUEUE", remove: "REMOVE A MOVIE FROM YOUR QUEUE",
    random: "SELECT A RANDOM MOVIE FROM YOUR QUEUE", all: "SEE ALL MOVIES IN YOUR QUEUE",
    genre: "SEE ALL MOVIES IN YOUR QUEUE BY GENRE", movies: "SHOW ALL MOVIES IN DATABASE",
    quit: "QUIT"
  }
end
