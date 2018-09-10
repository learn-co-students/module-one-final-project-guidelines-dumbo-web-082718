class Foodtruck < ActiveRecord::Base
  has_many :reviews

  def avg_rating
    sum = 0
    self.reviews.each { |review| sum += review.rating }
    sum / self.reviews.length
  end
  
end
