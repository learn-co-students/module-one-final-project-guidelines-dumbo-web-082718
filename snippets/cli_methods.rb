def introduction
  puts "Hello, welcome to MovieQueueApp™.".blue.bold
end

def get_user_name
puts "Please enter your username:".blue.bold
  while user_input = gets.chomp.downcase
    if user_input.length >= 4
      name = user_input
      return User.all.find_or_create_by(name: name)
      break
    else
      puts "INVALID INPUT: USERNAME MUST BE GREATER THAN 4 CHARACTERS. PLEASE TRY AGAIN".red
    end
  end
end

def options
  options = {
    add: "ADD MOVIE TO YOUR QUEUE", remove: "REMOVE A MOVIE FROM YOUR QUEUE",
    random: "SELECT A RANDOM MOVIE FROM YOUR QUEUE", all: "SEE ALL MOVIES IN YOUR QUEUE",
    genre: "SEE ALL MOVIES IN YOUR QUEUE BY GENRE", movies: "SHOW ALL MOVIES IN DATABASE",
    quit: "QUIT"
  }
end

def genre_array
  array = ["Comedy", "Science Fiction", "Horror", "Romance", "Action", "Thriller", "Drama", "Mystery", "Crime", "Animation", "Adventure", "Fantasy", "Comedy-Romance", "Action-Comedy", "SuperHero"]
end

def error_message
  puts "YOU DO NOT HAVE ANY MOVIES SAVED IN YOUR QUEUE".red.bold
end

def methods
  prompt = TTY::Prompt.new
  user_name =  get_user_name
  puts  "Hey #{user_name.name}!".blue.bold
  sleep(1)

  while true
    sleep(1)
    user_choice = prompt.select("What would you like to do?".blue.bold, options.values)

    if user_choice == options.values[0] #add
     title = prompt.ask('Enter a movie title:'.blue)
     loop do
     if title.nil?
       title = prompt.ask('Enter a movie title:'.blue)
     end
     break if title
   end
     genre = prompt.select("Select a genre:".blue, genre_array)
     release_year = prompt.ask("Enter movie's release year:".blue) do |q|
       q.in(0..Time.now.year)
       q.messages[:range?] = '%{value} is an Invalid Input'
       q.modify :strip, :collapse
     end
     loop do
       if release_year.nil?
         release_year
       end
       break if release_year
     end
     user_name.add_movie_to_database_and_queue(title, genre, release_year)
     puts "#{title} was added to your queue!".green.bold

    elsif user_choice == options.values[1] #remove
      if user_name.show_movies_in_user_list.empty?
        error_message
      else
        movie = prompt.select("Select a movie to delete:".blue, user_name.show_movies_in_user_list)
        user_name.remove_movie_in_user_list(movie)
        puts "#{movie} was removed from your queue!".green.bold
      end

    elsif user_choice == options.values[2] #random
      if user_name.show_movies_in_user_list.empty?
        error_message
      else
        puts user_name.pick_random_movie.title
      end

    elsif user_choice == options.values[3] #see movies in queue
      if user_name.show_movies_in_user_list.empty?
        error_message
      else
        puts user_name.show_movies_in_user_list
      end

    elsif user_choice == options.values[4] #show movie by genre
      genre = prompt.select("Select a genre:", genre_array)
      movies_with_genre = user_name.show_by_genre(genre)
        if movies_with_genre.empty?
          puts "YOU DO NOT HAVE ANY MOVIES SAVED IN YOUR QUEUE WITH THIS GENRE".red.bold
        else
          puts movies_with_genre
        end

    elsif user_choice == options.values[5] #show all movies in database
      puts Movie.show_all_movies_in_database

    elsif user_choice == options.values[6] #exit
      puts "Thanks for using MovieQueueApp™! Goodbye!".blue.bold
      break
    end
  end

end
