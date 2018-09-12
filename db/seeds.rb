require 'faker'

# seeds food trucks
Foodtruck.destroy_all
User.destroy_all
Review.destroy_all

25.times do
  Foodtruck.create(
    name: Faker::Restaurant.name,
    neighborhood: Faker::Address.community,
    cuisine: Faker::Restaurant.type
  )
end

50.times do
  User.create(
    username: Faker::Internet.username,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    password: Faker::Internet.password
  )
end

200.times do
  Review.create(
    title: Faker::Food.dish,
    rating: rand(1..10),
    comment: Faker::Restaurant.review,
    user_id: rand(1..50),
    foodtruck_id: rand(1..25)
  )
end
