require_relative '../config/environment'

puts "New or existing user?"
name = gets.chomp
User.find_by(name)

puts "Hello  welcome to MovieQueueApp™."

puts "-choice2"
