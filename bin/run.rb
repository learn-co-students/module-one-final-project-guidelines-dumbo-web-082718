require_relative '../config/environment'
require_relative '../snippets/cli_methods.rb'


introduction
sleep(1)
prompt = TTY::Prompt.new
user_name =  get_user_name
puts  "Hey #{user_name.name}!".blue.bold
sleep(1)

while true
  sleep(1)
  user_choice = prompt.select("What would you like to do?".blue.bold, options.values)
  if user_choice == options.values[0]
    title = prompt.ask('Enter a movie title:'.blue)
    genre = prompt.select("Select a genre:".blue, genre_array)
    release_year = prompt.ask("Enter movie's release year:".blue)
    user_name.add_movie_to_database_and_queue(title, genre, release_year)
    puts "#{title} was added to your queue!".green.bold
  elsif user_choice == options.values[1]
    movie = prompt.ask('Enter a movie title to remove:'.blue)
    if user_name.show_movies_in_user_list.empty?
      error_message
    else
      user_name.remove_movie_in_user_list(movie)
      puts "#{movie} was removed from your queue!".green.bold
    end

  elsif user_choice == options.values[2]
    if user_name.show_movies_in_user_list.empty?
      error_message
    else
      puts user_name.pick_random_movie.title
    end

  elsif user_choice == options.values[3]
    if user_name.show_movies_in_user_list.empty?
      error_message
    else
      puts user_name.show_movies_in_user_list
    end

  elsif user_choice == options.values[4]
    genre = prompt.select("Select a genre:", genre_array)
    movies_with_genre = user_name.show_by_genre(genre)
      if movies_with_genre.empty?
        puts "YOU DO NOT HAVE ANY MOVIES SAVED IN YOUR QUEUE WITH THIS GENRE".red.bold
      else
        puts movies_with_genre
      end

  elsif user_choice == options.values[5]
    puts Movie.show_all_movies_in_database

  elsif user_choice == options.values[6]
    puts "Thanks for using MovieQueueApp™! Goodbye!".blue.bold
    break
  end
end
