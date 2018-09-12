class Movie < ActiveRecord::Base
  has_many :list_items
  has_many :users, through: :list_items

  def self.show_all_movies_in_database
    self.all.map do |movie|
      "TITLE #{movie.title}, GENRE #{movie.genre}, RELEASE YEAR #{movie.release_year}"
    end
  end
end
