Prompt = TTY::Prompt.new(interrupt: :exit)

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

  case Prompt.select("Choose an option:", ["Login", "Create Account", "Exit"])
    when "Login"
      login
    when "Create Account"
      create_account
    when "Exit"
      exit
  end
end


def login
  login_user = loop do
    login_username = Prompt.ask('Username:')
    user_check = User.find_by(username:login_username)
    break user_check unless user_check == nil
    puts "That username does not exist."
  end

  loop do
    password = Prompt.mask('Password:')
    break if password == login_user.password
    puts "Your password is incorrect."
  end

  $program_user = login_user

end


def create_account
  loop do
    username = loop do
      newusername = Prompt.ask("Create your username:")
      username_check = User.find_by(username:newusername)
      break newusername if username_check == nil
      puts "That username is already taken."
    end

    firstname = Prompt.ask("Enter your first name:")
    lastname = Prompt.ask("Enter your last name:")
    password = Prompt.mask("Create your password:")
    if Prompt.yes?("Is this information correct?:")
      $program_user = User.create(username:username,first_name:firstname,last_name:lastname,password:password)
      break
    end
  end
end


def delete_account
  if Prompt.yes?("Do you really want to delete your account?")
    $program_user.reviews.delete_all
    $program_user.delete
    puts "Goodbye for now!"

    exit
  else
    puts "Thank you for staying with us!"
  end
end


def program_loop

    case Prompt.select("What would you like to view?", ["User", "Food Trucks", "My Reviews", "Exit"])
      when "User"
        user_loop
      when "Food Trucks"
        foodtruck_loop
      when "My Reviews"
        my_reviews
      when "Exit"
        exit
    end

end


def user_loop
  loop do

    puts "Username: #{$program_user.username} | First name: #{$program_user.first_name} | Last name: #{$program_user.last_name}"

    case Prompt.select("What would you like to do?", ["Change First Name", "Change Last Name", "Change Password", "Delete Account", "Back"])
      when "Change First Name"
        first_name = Prompt.ask('New first name:')
        $program_user.update(first_name: first_name)
      when "Change Last Name"
        last_name = Prompt.ask('New last name:')
        $program_user.update(last_name: last_name)
      when "Change Password"
        loop do
          password = Prompt.mask('Current password:')
          break if password == $program_user.password
          puts "Your password is incorrect."
        end
          new_password = Prompt.mask('New password:')
          $program_user.password = new_password
      when "Delete Account"
        delete_account
      when "Back"
        break
    end
  end
end


def foodtruck_loop
  loop do

    case Prompt.select("What would you like to do?", ["View All", "Search By Neighborhood", "Search By Cuisine", "Back"])
      when "View All"
        search_by(:name)
      when "Search By Neighborhood"
        search_by(:neighborhood)
      when "Search By Cuisine"
        search_by(:cuisine)
      when "Back"
        break
    end
  end
end


def search_by(arg)
  array = Foodtruck.all.map {|foodtruck| foodtruck.send arg }.uniq.sort
  case result = Prompt.select("Select a #{arg}", array, "Back", filter:true)
    when "Back"
      return
    else
      if arg == :name
        foodtruck_detail_menu(result)
      else
        select_foodtruck("#{arg}":result)
      end
  end
end


def select_foodtruck(arg)
  foodtruck_array = Foodtruck.where(arg).map { |foodtruck| foodtruck.name }
  case truck_name = Prompt.select("Select a foodtruck:", foodtruck_array, "Back")
    when "Back"
      return
    else
      foodtruck_detail_menu(truck_name)
  end
end


def foodtruck_detail_menu(truck_name)
  truck = Foodtruck.find_by(name:truck_name)
  loop do
    puts "Name: #{truck.name} | Average Rating: #{truck.avg_rating} | Neighborhood: #{truck.neighborhood} | Cuisine: #{truck.cuisine}"

    case Prompt.select("What would you like to do?", ["View Menu", "See Reviews", "Leave Review", "Back"])
      when "View Menu"
        menu_table(truck)
      when "See Reviews"
        review_table(truck)
      when "Leave Review"
        create_review_selected(truck)
      when "Back"
        break
    end
  end
end


def menu_table(truck)
  table = TTY::Table.new header: ["Name", "Price"]
  ["Appetizer", "Lunch", "Dinner", "Dessert"].each { |category| category_table("#{category}", truck, table) }
end


def category_table(arg, truck, table)
  array = truck.foods.where(category: arg).map { |food| [food.name, "$#{food.price}"] }
  array.each { |food| table << food }
  puts "- #{arg} - \n"
  puts table.render(:ascii, column_widths:[30, 10], multiline: true, resize:true) { |renderer| renderer.border.separator = :each_row }
end


# def review_loop
#   loop do
#     case Prompt.select("What would you like to do?", ["View Your Reviews", "View All Reviews", "Create Review", "Back"])
#       when "View Your Reviews"
#         tp Review.where(user_id:$program_user.id)
#       when "View All Reviews"
#         tp Review.all, "title", "rating", "comment", "user.username", "foodtruck.name"
#       when "Create Review"
#         create_review
#       when "Back"
#         break
#     end
#   end
# end

def my_reviews
  review_array = $program_user.reviews.map { |review| {name: "#{review.foodtruck.name} - #{review.title}", value: review} }
  case result = Prompt.select("Select a review: ", review_array, "Back")
    when "Back"
      return
    else
      my_review_detail(result)
  end
end

def my_review_detail(review)
  puts "Title: #{review.title} | Rating: #{review.rating} | Comment: #{review.comment} | Foodtruck: #{review.foodtruck.name}"
  loop do
    case Prompt.select("What would you like to do?", ["Edit Review", "Delete Review", "Back"])
    when "Edit Review"
      #edit_review
    when "Delete Review"
      #delete_review
    when "Back"
      break
    end
  end
end



def create_review
  food_truck = valid_truck?
  title = Prompt.ask("Title:")
  rating = Prompt.ask("Rating from 1-10:") { |q| q.in('1-10') }
  comment = Prompt.ask("Comment:")
  #Print and confirm with user if they want to submit with y/n
  Review.create(title:title,rating:rating,comment:comment,user_id:$program_user.id,foodtruck_id:food_truck.id)
end

def create_review_selected(truck)
  loop do
    title = Prompt.ask("Title:")
    rating = Prompt.ask("Rating from 1-10:") { |q| q.in('1-10') }
    comment = Prompt.ask("Comment:")
    if Prompt.yes?("Submit this review for #{truck.name}?:")
      Review.create(title:title,rating:rating,comment:comment,user_id:$program_user.id,foodtruck_id:truck.id)
      break
    end
  end
end


def valid_truck?
  loop do
    food_truck_name=Prompt.ask('Food truck name:')
    food_truck = Foodtruck.find_by(name:food_truck_name)
    break food_truck unless food_truck == nil
    puts "Please enter a valid truck name."
  end
end


def review_table(truck)
  table = TTY::Table.new header: ["Title", "Rating", "Comment", "User"]

  reviews_array = truck.reviews.map { |review| [review.title, review.rating, review.comment, review.user.username] }
  reviews_array.each { |review| table << review }

  puts table.render(:ascii, column_widths:[20, 7, 55, 20], multiline: true, resize:true) { |renderer| renderer.border.separator = :each_row }
end
