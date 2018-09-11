Prompt = "Input > "



def initialize_user
  puts <<-FOO
Welcome to Placeholder App Name.
What is your name?
FOO
  print Prompt
  user_name = gets.chomp
  $program_user = User.find_or_create_by(name:user_name)
end


def program_loop

  loop do

    case main_what_do
      when "User"
        user_loop
      when "Food_Trucks"
        #foodtruck_loop
      when "Reviews"
        #review_loop
      when "Exit"
        break
    end
  end
  exit
end

def main_what_do
prompt = TTY::Prompt.new
prompt.select("What would you like to view?", %w(User Food_Trucks Reviews Exit))
end

def user_what_do
  prompt = TTY::Prompt.new
  prompt.select("Where would you like to go?", %w(Change_Name Back))
end


def user_loop
  loop do
    puts "NAME: #{$program_user.name}"
    case user_what_do
    when "Change_Name"
      name = TTY::Prompt.new
      new_name = name.ask('What is your name?', default: $program_user.name)
      $program_user.name = new_name
      $program_user.save
    when "Back"
      break
    end
  end
end

def foodtruck_loop
  #foodtruck_what_do
end

def review_loop
  #review_what_do
end

def print_foodtrucks
# table = TTY::Table.new ['header1','header2'], [['a1', 'a2'], ['b1', 'b2']]
# table.render(:ascii)
tp Foodtruck.all, "name", "avg_rating"
end
