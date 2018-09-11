class ListItems < ActiveRecord::Base
  belongs_to :user
  belongs_to :movie

  def show_a_users_lists
    #will show the user all of their list/queues.
  end

  def show_movies_in_a_list
    #will show all of the movies in a given list
  end

  def remove_movie
    #removes a movie from their list/queue.
  end
  #
  # def add_movie(user_id, movie_id)
  #   #adds a movie to their list/queue.
  #   (user_id, movie_id)


  def pick_random_movie
    #picks a random movie from a given list
  end

end
