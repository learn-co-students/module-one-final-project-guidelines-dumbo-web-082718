class ListItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :movie


  #
  # def add_movie(user_id, movie_id)
  #   #adds a movie to their list/queue.
  #   (user_id, movie_id)


  def pick_random_movie
    #picks a random movie from a given list
  end

end
