Prompt = "Input > "

def initialize_user
  puts <<-FOO
Welcome to Placeholder App Name.
What is your name?
FOO
  print Prompt
  user_name = gets.chomp
  @program_user = User.find_or_create_by(name:user_name)
end

def what_do
  puts <<-FOO
What would you like to do:
1. View all food trucks.
2. View your reviews.
3. Add new review.
FOO
print Prompt
input = gets.chomp

end

def print_foodtrucks
# table = TTY::Table.new ['header1','header2'], [['a1', 'a2'], ['b1', 'b2']]
# table.render(:ascii)
tp Foodtruck.all, "name", "avg_rating"
end
