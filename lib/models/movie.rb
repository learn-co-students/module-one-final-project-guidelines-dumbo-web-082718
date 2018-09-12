class Movie < ActiveRecord::Base
  has_many :list_items
  has_many :users, through: :list_items

  def show_all_movies_in_database
    Movie.all
  end
end
