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


# def user_options(name)
#   puts "Welcome #{name}! what would you like to do?
#   -Type 'add' to add movie to your queue.
#   -Type 'remove' to remove a movie from your queue.
#   -Type 'random' to choose a random movie from your queue.
#   -Type 'all' to see all movies in your queue.
#   -Type 'genre' to show movies in your queue by genre.
#   -Type 'movies' to show all movies in database." #think of another word besides database
# end

# one_or_two = prompt.select("Choose '1' if you're an existing user or '2' to create a new account:", %w(1 2))

# if one_or_two == '1'
#   sleep(1)
#   user_name = option_one
#  elsif one_or_two == '2'
#   sleep(1)
#   user_name = option_two
# end

# user_name = prompt.ask('Please enter your name:')
# User.all.find_or_create_by(name: name)
