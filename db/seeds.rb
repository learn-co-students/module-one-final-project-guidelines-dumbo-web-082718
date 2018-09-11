require 'faker'

# seeds food trucks
Foodtruck.destroy_all

15.times do
  Foodtruck.create(
    name: Faker::Restaurant.name,
    neighborhood: Faker::Address.community,
    cuisine: Faker::Restaurant.type
  )
end
