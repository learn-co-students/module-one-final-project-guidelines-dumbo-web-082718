def introduction
  puts "Hello, welcome to MovieQueueApp™."
end

def get_user_name
puts "Please enter your username:"
  while user_input = gets.chomp.downcase
    if user_input.length >= 4
      name = user_input
      return User.all.find_or_create_by(name: name)
      break
    else
      puts "INVALID INPUT: USERNAME MUST BE GREATER THAN 4 CHARACTERS. PLEASE TRY AGAIN"
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
  array = ["Comedy", "Sci-Fi", "Horror", "Romance", "Action", "Thriller", "Drama", "Mystery", "Crime", "Animation", "Adventure", "Fantasy", "Comedy-Romance", "Action-Comedy", "SuperHero"]
end
