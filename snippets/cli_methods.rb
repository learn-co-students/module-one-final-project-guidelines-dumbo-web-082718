# require "pry"



def introduction
  puts "Hello, welcome to MovieQueueApp™."
end

def get_user_name
    puts "Please enter your username"
  while user_input = gets.chomp.downcase
    if user_input.length >= 4
      name = user_input
      return User.all.find_or_create_by(name: name)
      break # make sure to break so you don't ask again
    else
      puts "INVALID INPUT. USERNAME MUST BE GREATER THAN 4 CHARACTERS"
      puts "PLEASE TRY AGAIN"
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
