def initialize_user
  puts "Welcome to FoodTruck Finder"
  prompt = TTY::Prompt.new
  case prompt.select("Choose an option:", %w(Login Create\ account Exit))
    when "Login"
      login
    when "Create account"
      create_account
    when "Exit"
      exit
  end
end

def login
  login_user = loop do
    login_username=TTY::Prompt.new.ask('Username:')
    user_check = User.find_by(username:login_username)
    break user_check unless user_check == nil
    puts "That username does not exist."
  end

  loop do
    password = TTY::Prompt.new.mask('Password:')
    break if password == login_user.password
    puts "Your password is incorrect."
  end

  $program_user = login_user
end

def create_account
  username = loop do
    newusername = TTY::Prompt.new.ask("Create your username:")
    username_check = User.find_by(username:newusername)
    break newusername if username_check == nil
    puts "That username is already taken."
  end
  firstname = TTY::Prompt.new.ask("Enter your first name:")
  lastname = TTY::Prompt.new.ask("Enter your last name:")
  password = TTY::Prompt.new.mask("Create your password:")
  #print ask yes/no
  $program_user = User.create(username:username,first_name:firstname,last_name:lastname,password:password)
end




def program_loop
  loop do
    case main_what_do
      when "User"
        user_loop
      when "Food Trucks"
        foodtruck_loop
      when "Reviews"
        review_loop
      when "Exit"
        break
    end
  end
  exit
end

def main_what_do
  prompt = TTY::Prompt.new
  prompt.select("What would you like to view?", %w(User Food\ Trucks Reviews Exit))
end

def user_what_do
  prompt = TTY::Prompt.new
  prompt.select("Where would you like to go?", %w(Change\ first\ name Back))
end


def user_loop
  loop do
    puts "Username: #{$program_user.username} | First name: #{$program_user.first_name} | Last name: #{$program_user.last_name}"
    case user_what_do
    when "Change first name"
      name = TTY::Prompt.new
      new_name = name.ask('What is your new first name?', default: $program_user.first_name)
      $program_user.first_name = new_name
      $program_user.save
    when "Back"
      break
    end
  end
end

def foodtruck_what_do
  prompt = TTY::Prompt.new
  prompt.select("What would you like to do?", %w(View\ All Search\ By\ Name Search\ by\ Neighborhood Search\ By\ Cuisine Back))
end

def foodtruck_loop
  loop do
    case foodtruck_what_do
    when "View All"
      print_foodtrucks
    when "Search By Name"
      name = TTY::Prompt.new
      food_truck_name=name.ask('Food truck name:')
      tp Foodtruck.where(name:food_truck_name)
    when "Search by Neighborhood"
      hood = TTY::Prompt.new
      hood_name=hood.ask('Neighborhood:')
      tp Foodtruck.where(neighborhood:hood_name)
    when "Search By Cuisine"
      cuisine = TTY::Prompt.new
      cuisine_name=cuisine.ask('Cuisine:')
      tp Foodtruck.where(cuisine:cuisine_name)
    when "Back"
      break
    end
  end
end

def review_loop
  loop do
    case review_what_do
    when "View Your Reviews"
      tp Review.where(user_id:$program_user.id)
    when "Create Review"
      create_review
    when "Back"
      break
    end
  end
end

def review_what_do
  prompt = TTY::Prompt.new
  prompt.select("What would you like to do?", %w(View\ Your\ Reviews Create\ Review Back))
end

def create_review
  food_truck = valid_truck?
  title = TTY::Prompt.new.ask("Title:")
  rating = TTY::Prompt.new.ask("Rating from 1-10:") { |q| q.in('1-10') }
  comment = TTY::Prompt.new.ask("Comment:")
  #Print and confirm with user if they want to submit with y/n
  Review.create(title:title,rating:rating,comment:comment,user_id:$program_user.id,foodtruck_id:food_truck.id)
end

def valid_truck?
  loop do
    food_truck_name=TTY::Prompt.new.ask('Food truck name:')
    food_truck = Foodtruck.find_by(name:food_truck_name)
    break food_truck unless food_truck == nil
    puts "Please enter a valid truck name."
  end
end

def print_foodtrucks
  tp Foodtruck.all, "name", "neighborhood", "cuisine"
end
