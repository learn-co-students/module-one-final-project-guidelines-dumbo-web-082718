require_relative '../config/environment'
require_relative '../snippets/cli_methods.rb'


introduction
sleep(1)
prompt = TTY::Prompt.new
one_or_two = prompt.select("Choose '1' if you're an existing user or '2' to create a new account:", %w(1 2))

if one_or_two == '1'
  sleep(1)
   user_name = option_one
 elsif one_or_two == '2'
   sleep(1)
   user_name = option_two
end

puts  "Hey #{user_name.name}!"
sleep(1)

while true
  sleep(2)
  user_choice = prompt.select("What would you like to do?", options.values)
  if user_choice == options.values[0]
    title = prompt.ask('Enter a movie title:')
    genre = prompt.select("Select a genre:", %w(Comedy Sci-Fi Horror Romance Action Thriller Drama Mystery Crime Animation Adventure Fantasy Comedy-Romance Action-Comedy SuperHero))
    release_year = prompt.ask("Enter movie's release year:")
    user_name.add_movie_to_database_and_queue(title, genre, release_year)
  elsif user_choice == options.values[1]
     movie = prompt.ask('Enter a movie title to remove:')
     user_name.remove_movie_in_user_list(movie)
  elsif user_choice == options.values[2]
     puts user_name.pick_random_movie.title
  elsif user_choice == options.values[3]
    puts user_name.show_movies_in_user_list
  elsif user_choice == options.values[4]
    genre = prompt.select("Select a genre:", %w(Comedy Sci-Fi Horror Romance Action Thriller Drama Mystery Crime Animation Adventure Fantasy Comedy-Romance Action-Comedy SuperHero))
    if user_name.show_by_genre(genre) == nil
      puts "YOU DO NOT HAVE ANY MOVIES SAVED WITH THIS GENRE."
    else
      puts user_name.show_by_genre(genre)
    end

  elsif user_choice == options.values[5]
    puts Movie.show_all_movies_in_database
  elsif user_choice == options.values[6]
    break
  end
end
