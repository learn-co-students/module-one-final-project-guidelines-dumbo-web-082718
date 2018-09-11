class User < ActiveRecord::Base
  has_many :lists
  has_many :movies, through: :lists


  def create_movie
    #user can input movie's attributes and this method will create
    #a new movie which puts it in the database and is also added to the
    #user's list.
  end

  

end
