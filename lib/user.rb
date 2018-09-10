class User < ActiveRecord::Base
  has_many :reviews



  def new_review
    title = gets.chomp

    comment = gets.chomp
    Review.new()
  end

  def valid_rating?
    while rating = gets.chomp.to_i
      case rating
        when 1...10
          rating
        else
          puts "Please insert a valid number."
        end
      end
    end


end
