class Movie < ActiveRecord::Base
  has_many :list_items
  has_many :users, through: :list_items
end
