require_relative '../config/environment'
require_relative '../snippets/cli_methods.rb'

introduction

user_input = gets.chomp

case user_input
  when user_input == '1'
    option_one
  when user_input =='2'
    option_two
  when
    puts 'Invalid input'
  end
end


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
