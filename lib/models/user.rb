class User < ActiveRecord::Base
  has_many :list_items
  has_many :movies, through: :list_items


  def show_movies_in_user_list
    #will show all movies in a user's list
    ListItems.all.select do |list|
      list.user_id == self
    end
  end

  def remove_movie_in_user_list
    #removes a movie from their list/queue.

  end

  # def add_movie_to_database(movie_id)
  #   ListItems.create(movie_id, self)
  # end


end
