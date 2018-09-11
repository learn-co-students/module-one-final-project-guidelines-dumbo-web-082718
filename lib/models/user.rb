class User < ActiveRecord::Base
  has_many :list_items
  has_many :movies, through: :list_items

  def show_movies_in_user_list
    #will show all movies in a user's list
    movies.map do |movie|
      movie.title
    end
  end

  def remove_movie_in_user_list(movie)
    #removes a movie from their list/queue.
    found_list_item = self.list_items.find do |list_item|
      list_item.movie.title == movie
    end
    found_list_item.destroy
  end

  # def add_movie_to_database(movie_id)
  #   ListItems.create(movie_id, self)
  # end


end
