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
    add: "Choose 'add' to add movie to your queue.", remove: "Choose 'remove' to remove a movie from your queue.",
    random: "Choose 'random' to select a random movie from your queue.", all: "Choose 'all' to see all movies in your queue.",
    genre: "Choose 'genre', to show all movies in your queue by genre", movies: "Choose 'movies' to show all movies in database."
  }
end
