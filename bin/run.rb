require_relative '../config/environment'

Program_user = loop do
  user_instance = initialize_user
  break user_instance unless user_instance == nil
  end # sets constant to return value from this method, which will be an instance of the User class if login/create account methods are valid.

loop do # main program loop
  program_loop
end
