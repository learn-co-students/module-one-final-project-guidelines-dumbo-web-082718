class User < ActiveRecord::Base
  has_many :list_items
  has_many :movies, through: :list_items

  def show_movies_in_user_list
    movie_titles = ListItem.where(user_id:self.id).map{|item| item.movie.title}
  end

  def movies_genres(genre)
    movie_titles = ListItem.where(user_id:self.id)
    one = movie_titles.select { |listitem| listitem.movie.genre == genre }
    two = one.map { |listitem| listitem.movie.title }
    # binding.pry
  end

  def remove_movie_in_user_list(movie)
    found_list_item = self.list_items.find do |list_item|
      list_item.movie.title == movie
    end
    found_list_item.delete
  end

  def pick_random_movie
    self.movies.sample
  end

  def add_movie(title, genre, release_year)
    Movie.find_or_create_by(title: title, genre: genre, release_year: release_year)
  end

  def add_movie_to_database_and_queue(title, genre, release_year)
    new_movie = self.add_movie(title, genre, release_year)
    ListItem.find_or_create_by(user_id: self.id, movie_id: new_movie.id)
  end

  def show_by_genre(genre)
    selected_movies =
    movies.select do |movie|
      movie.genre == genre
    end
    selected_movies.map do |movie|
      movie.title
    end
  end

end
