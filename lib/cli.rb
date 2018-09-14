Prompt = TTY::Prompt.new(interrupt: :exit) #constant for calling TTY-Prompt

def initialize_user # method called when app opens
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
      return login # calls login method, returns user instance, ends method
    when "Create Account"
      return create_account # calls create_account method, returns user instance created, ends method
    when "Exit"
      exit # exits the program
  end
end # initialize_user


def login
  loop do
    username = Prompt.ask('Username:') { |q| q.modify :strip }
    password = Prompt.mask('Password:') { |q| q.modify :strip }
    user = User.find_by(username:username, password:password) # sets variable equal to user instance matching input, or nil if not found
    break user unless user == nil # returns user instance on break, puts line below and continues loop if user info doesnt match input
    puts "Your login information is incorrect."
  end
end # login


def create_account
  loop do
    username = loop do # sets variable equal to return value of loop
      newusername = Prompt.ask("Create your username:")
      username_check = User.find_by(username:newusername) # sets variable equal to user instance matching input, or nil if not found
      break newusername if username_check == nil # breaks and returns username inputted if no name is found so that usernames remain unique, othrwise puts line below and continues loop
      puts "That username is already taken."
    end

    firstname = Prompt.ask("Enter your first name:") { |q| q.modify :strip }
    lastname = Prompt.ask("Enter your last name:") { |q| q.modify :strip }
    password = Prompt.mask("Create your password:") { |q| q.modify :strip }
    if Prompt.yes?("Is this information correct?:") # confirmation for correct info
      break User.create(username:username,first_name:firstname,last_name:lastname,password:password) # creates user and returns user instance on break if yes was selected
    end
  end
end # create_account


def delete_account
  if Prompt.yes?("Do you really want to delete your account?") # confirmation for user's intent
    Program_user.reviews.delete_all # deletes all of user's reviews from db
    Program_user.delete # deletes the user from db
    puts "Goodbye for now!"

    exit # exits the program
  else
    puts "Thank you for staying with us!"
  end
end # delete_account


def program_loop # main menu
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
end # program_loop


def user_loop # user menu
  loop do
    puts "Username: #{Program_user.username} | First name: #{Program_user.first_name} | Last name: #{Program_user.last_name}"

    case Prompt.select("What would you like to do?", ["Change First Name", "Change Last Name", "Change Password", "Delete Account", "Back"])
      when "Change First Name"
        first_name = Prompt.ask('New first name:') { |q| q.modify :strip }
        Program_user.update(first_name: first_name) # sets first name to user input
      when "Change Last Name"
        last_name = Prompt.ask('New last name:') { |q| q.modify :strip }
        Program_user.update(last_name: last_name) # sets last name to user input
      when "Change Password"
        loop do
          password = Prompt.mask('Current password:') { |q| q.modify :strip }
          break if password == Program_user.password # checks user if knows current password, loops if incorrect
          puts "Your password is incorrect."
        end
          new_password = Prompt.mask('New password:') { |q| q.modify :strip }
          Program_user.update(password: new_password) #sets password to user input
      when "Delete Account"
        delete_account
      when "Back"
        break # breaks user_loop and goes back to #program_loop
    end
  end
end # user_loop


def foodtruck_loop # main foodtruck menu
  loop do
    case Prompt.select("What would you like to do?", ["View All", "Search By Neighborhood", "Search By Cuisine", "Back"])
      when "View All"
        search_by(:name) # see method below for explanation for this nonsense
      when "Search By Neighborhood"
        search_by(:neighborhood)
      when "Search By Cuisine"
        search_by(:cuisine)
      when "Back"
        break # breaks foodtruck_loop and goes back to #program_loop
    end
  end
end #foodtruck_loop


def search_by(arg) # takes in an argument, either ":name", ":neighborhood", or ":cuisine" from the foodtruck_loop and searches based on those. they're symbols due to the send within the map block
  array = Foodtruck.all.map { |foodtruck| foodtruck.send arg }.uniq.sort # sets variable equal to an array of foodtruck names, their neighborhoods, or their cuisine type. we iterate over all the foodtruck instances using .map and call a method within the block on each instance using .send -- the method is determined by the argument passed into #search_by (so either .name, .neighborhood, or .cuisine). makes sure the array has only unique elements, sorted alphabetically.
  case result = Prompt.select("Select a #{arg}", array, "Back", filter:true) # interpolates arg as string within the TTY-Prompt, uses the array from above as choice of option, sets a variable equal to the return value of the prompt
    when "Back"
      return
    else
      if arg == :name # if the arg is name, the result is going to be an individual food truck, so we want to go to the detail view of that food truck, since #select_foodtruck would only show one
        foodtruck_detail_menu(result)
      else
        select_foodtruck("#{arg}":result) # passes along argument passed into #search_by as the key to a hash, with the value being the result from the user selection, for example: {neighborhood: "University Oaks"}
      end
  end
end # search_by


def select_foodtruck(arg) #takes in a hash as an argument from #search_by
  foodtruck_array = Foodtruck.where(arg).map { |foodtruck| foodtruck.name } # sets a variable equal to an array. that array is created by mapping over each food truck instance with conditions equal to the hash passed in, and using its name for readability.
  case truck_name = Prompt.select("Select a foodtruck:", foodtruck_array, "Back") # sets variable equal to return value from selection (which would be a truck name). uses above array as list of options
    when "Back"
      return # ends method and returns to #foodtruck_loop
    else
      foodtruck_detail_menu(truck_name)
  end
end # select_foodtruck


def foodtruck_detail_menu(truck_name) # detail view for trucks
  truck = Foodtruck.find_by(name:truck_name) # finds foodtruck instance by name passed in and sets variable equal to the instance
  loop do
    puts "Name: #{truck.name} | Average Rating: #{truck.avg_rating} | Neighborhood: #{truck.neighborhood} | Cuisine: #{truck.cuisine}"

    case Prompt.select("What would you like to do?", ["View Menu", "See Reviews", "Leave Review", "Back"])
      when "View Menu"
        menu_table(truck)
      when "See Reviews"
        review_table(truck)
      when "Leave Review"
        create_review(truck)
      when "Back"
        break
    end
  end
end # foodtruck_detail_menu


def menu_table(truck) # takes in instance of truck as argument
  table = TTY::Table.new header: ["Name", "Price"]
  ["Appetizer", "Lunch", "Dinner", "Dessert"].each { |category| category_table("#{category}", truck, table) } # iterates over an array of categories, and for each, calls a method to print a table by passing along the category, the food truck, and the table
end # menu_table


def category_table(category, truck, table) # prints a menu for a specific category
  array = truck.foods.where(category: category).map { |food| [food.name, "$#{food.price}"] } # makes an array of arrays of food names and prices, from all food instances where the category is equal to the category passed in as an argument.
  array.each { |food| table << food } # iterates over array and pushes to TTY-Table
  puts "- #{category} - \n"
  puts table.render(:ascii, column_widths:[30, 10], multiline: true, resize:true) { |renderer| renderer.border.separator = :each_row } # this is all just TTY-Table options for rendering
end # category_table


def my_reviews # selectable list of all of the user's reviews
  review_array = Program_user.reviews.map { |review| {name: "#{review.foodtruck.name} - #{review.title}", value: review} } # maps over every review for the current user, creates an array of hashes per TTY-Prompt's syntax so that review selection is based on instance (name is visible selection, value is return value of selection)
  case result = Prompt.select("Select a review: ", review_array, "Back")
    when "Back"
      return # returns back to #program_loop
    else
      my_review_detail(result)
  end
end # my_reviews


def my_review_detail(review) # detail view for a review created by the user, argument is an instance of a review
  puts "Title: #{review.title} | Rating: #{review.rating} | Comment: #{review.comment} | Foodtruck: #{review.foodtruck.name}"
  loop do
    case Prompt.select("What would you like to do?", ["Edit Review", "Delete Review", "Back"])
    when "Edit Review"
      edit_review(review)
    when "Delete Review"
      if Prompt.yes?("Are you sure you want to delete this review?") # confirms user wants to delete review
        review.delete
        break # breaks loop and returns to #program_loop
      end
    when "Back"
      break # breaks loop and returns to #program_loop
    end
  end
end # my_review_detail


def create_review(truck) # takes in instance of food truck
  loop do
    title = Prompt.ask("Title:") { |q| q.modify :strip }
    rating = Prompt.ask("Rating from 1-10:") { |q| q.in('1-10') } # TTY-Prompt syntax for only allowing values in range
    comment = Prompt.ask("Comment:")
    if Prompt.yes?("Submit this review for #{truck.name}?:") { |q| q.modify :strip } # confirmation to create review
      break Review.create(title:title,rating:rating,comment:comment,user_id:Program_user.id,foodtruck_id:truck.id) # breaks loop and creates review
    end
  end
end # create_review


def edit_review(review) # takes in instance of review
  loop do
    title = Prompt.ask("Title:", default:review.title) { |q| q.modify :strip }
    rating = Prompt.ask("Rating from 1-10:") { |q| q.in('1-10') }
    comment = Prompt.ask("Comment:", default:review.comment) { |q| q.modify :strip }
    if Prompt.yes?("Edit this review for #{review.foodtruck.name}?:") # confirmation to edit review
      break review.update(title:title,rating:rating,comment:comment) # breaks and updates review with user input
    end
  end
end #edit_review


def review_table(truck) # takes in truck instance and prints truck's reviews
  table = TTY::Table.new header: ["Title", "Rating", "Comment", "User"]

  reviews_array = truck.reviews.map { |review| [review.title, review.rating, review.comment, review.user.username] } # creates an array of review information to pass on to TTY-Table
  reviews_array.each { |review| table << review }

  puts table.render(:ascii, column_widths:[20, 7, 55, 20], multiline: true, resize:true) { |renderer| renderer.border.separator = :each_row } # prints TTY-Table options
end # review_table
