class Foodtruck < ActiveRecord::Base
  has_many :reviews

  def avg_rating
    sum = 0
    if self.reviews.length == 0
      "No data."
    else
      self.reviews.each { |review| sum += review.rating }
      sum / self.reviews.length
    end
  end

end
