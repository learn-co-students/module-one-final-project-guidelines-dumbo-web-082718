def initialize_user
  puts <<-ASCII
                           - WELCOME TO -
  d888888b d8888b. db    db  .o88b. db   dD      d888888b d888888b
  `~~88~~' 88  `8D 88    88 d8P  Y8 88 ,8P'        `88'   `~~88~~'
     88    88oobY' 88    88 8P      88,8P           88       88
     88    88`8b   88    88 8b      88`8b           88       88
     88    88 `88. 88b  d88 Y8b  d8 88 `88.        .88.      88
     YP    88   YD ~Y8888P'  `Y88P' YP   YD      Y888888P    YP
  ASCII

  case TTY::Prompt.new.select("Choose an option:", %w(Login Create\ account Exit))
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
    login_username = TTY::Prompt.new.ask('Username:')
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


def delete_account
  if TTY::Prompt.new.yes?("Do you really want to delete your account?")
    $program_user.reviews.delete_all
    $program_user.delete
    puts "Goodbye forever!"

    exit
  else
    puts ":)"
  end
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
  prompt.select("What would you like to do?", %w(Change\ First\ Name Change\ Last\ Name Change\ Password Delete\ Account Back))
end


def user_loop
  loop do
    puts "Username: #{$program_user.username} | First name: #{$program_user.first_name} | Last name: #{$program_user.last_name}"
    case user_what_do
    when "Change First Name"
      new_name = TTY::Prompt.new.ask('What is your new first name?', default: $program_user.first_name)
      $program_user.first_name = new_name
      $program_user.save
    when "Change Last Name"
      last_name= TTY::Prompt.new.ask('What is your new last name?', default: $program_user.last_name)
      $program_user.last_name = last_name
      $program_user.save
    when "Change Password"
      loop do
        password = TTY::Prompt.new.mask('Insert current password:')
        break if password == $program_user.password
        puts "Your password is incorrect."
      end
        new_password = TTY::Prompt.new.mask('Insert new password:')
        $program_user.password = new_password
    when "Delete Account"
      delete_account
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
      search_by(:neighborhood)
    when "Search By Cuisine"
      search_by(:cuisine)
    when "Back"
      break
    end
  end
end

# def search_by_neighborhood
#   neighborhood_array = Foodtruck.all.map {|foodtruck| foodtruck.neighborhood}.uniq
#   neighborhood_do = TTY::Prompt.new.select("Select a neighborhood", neighborhood_array, "Back")
#   if neighborhood_do == "Back"
#     return
#   else
#     select_foodtruck(neighborhood:neighborhood_do)
#   end
# end
#
# def search_by_cuisine
#   cuisine_array = Foodtruck.all.map {|foodtruck| foodtruck.cuisine}.uniq
#   cuisine_do = TTY::Prompt.new.select("Select a cuisine", cuisine_array, "Back")
#   if cuisine_do == "Back"
#     return
#   else
#     select_foodtruck(cuisine:cuisine_do)
#   end
# end

def search_by(arg)
  array = Foodtruck.all.map {|foodtruck| foodtruck.send arg }.uniq.sort
  arg_do = TTY::Prompt.new.select("Select a #{arg}", array, "Back")
  if arg_do == "Back"
    return
  else
    select_foodtruck("#{arg}":arg_do)
  end
end

def select_foodtruck(arg)
  foodtruck_array = Foodtruck.where(arg).map { |foodtruck| foodtruck.name }
  foodtruck_do = TTY::Prompt.new.select("Select a foodtruck:", foodtruck_array, "Back")
  if foodtruck_do == "Back"
    return
  else
    # calls a method that displays the food truck's options "view menu" ""
    puts "truck off"
  end
end
# foodtruck_array = Foodtruck.where(neighborhood:neighborhood_do).map { |foodtruck| foodtruck.name }

def review_loop
  loop do
    case review_what_do
    when "View Your Reviews"
      tp Review.where(user_id:$program_user.id)
    when "View All Reviews"
      tp Review.all, "title", "rating", "comment", "user.username", "foodtruck.name"
    when "Create Review"
      create_review
    when "Back"
      break
    end
  end
end


def review_what_do
  prompt = TTY::Prompt.new
  prompt.select("What would you like to do?", %w(View\ Your\ Reviews View\ All\ Reviews Create\ Review Back))
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
  tp Foodtruck.all, "name", "avg_rating", "neighborhood", "cuisine"
end
