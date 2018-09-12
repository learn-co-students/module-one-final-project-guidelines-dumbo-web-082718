class User < ActiveRecord::Base
  has_many :list_items
  has_many :movies, through: :list_items

  def show_movies_in_user_list
    #will show all movies in a user's list(titles)
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

  def pick_random_movie
    #picks a random movie from a given list
    self.movies.sample
  end

  def add_movie(title, genre, release_year)
    #adds a movie to the database
    Movie.create(title: title, genre: genre, release_year: release_year)
  end

  def add_movie_to_database_and_queue(title, genre, release_year)
    new_movie = self.add_movie(title, genre, release_year)
    ListItem.create(user_id: self.id, movie_id: new_movie.id)
  end

  def show_by_genre(genre)
    movies.select do |movie|
      movie.genre == genre
    end
  end

  def show_all_movies_in_database
    Movie.all
  end
end
