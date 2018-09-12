require_relative '../config/environment'
require_relative '../snippets/cli_methods.rb'


puts "Hello, welcome to MovieQueueApp™."
prompt = TTY::Prompt.new
one_or_two = prompt.select("Choose '1' if you're an existing user or '2' to create a new account:", %w(1 2))

if one_or_two == '1'
   user_name = option_one
 elsif one_or_two == '2'
   user_name = option_two
end

options = {
  add: "Choose 'add' to add movie to your queue.", remove: "Choose 'remove' to removie a movie from your queue.",
  random: "Choose 'random' to select a random movie from your queue.", all: "Choose 'all' to see all movies in your queue.",
  genre: "Choose 'genre', to show all movies in your queue by genre", movies: "Choose 'movies' to show all movies in database."
}
user_choice = prompt.select("Welcome #{user_name.name}. What would you like to do?", options.values)

if user_choice = options.values[0]
  title = prompt.ask('Enter a movie title:')
  genre = prompt.select("Select a genre:", %w(Comedy Sci-Fi Horror Romance Action Thriller Drama Mystery Crime Animation Adventure Fantasy Comedy-Romance Action-Comedy SuperHero))
  release_year = prompt.ask("Enter movie's release year:")
  user_name.add_movie_to_database_and_queue(title, genre, release_year)
end
# introduction

# user_input = gets.chomp

# case user_input
# when user_input == '1'
#     option_one
#   when user_input =='2'
#     option_two
#   when
#     puts 'Invalid input'
#   end
# end

  # user_input = gets.chomp
  # if user_input == "1"
  #   option_one
  # elsif user_input == "2"
  #   option_two
  # else
  #   puts "Invalid input"
  #   sleep(2)
  #   introduction
  #   sleep(1)
  #   user_input = gets.chomp
  # end


# user_options(name)

 # if input == "update"
 #   #run a method to update
 # elsif input == "add"
 #   #run a method to add
 # elsif input == "add list"
 # else
 #   "Incorrect input. Try again."
 # end

# if user_input == "1"
#   puts "Please enter your username"
#   name = gets.chomp
#   User.all.find_by(name: name)
#   user_options(name)
# elsif user_input == "2"
#   puts "Please enter a new username"
#   new_name = gets.chomp
#   User.create(name: new_name)
# else
#   puts "Invalid input. Press 1 if you are an existing user and 2 to create a new account."
# end
