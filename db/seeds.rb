# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# puts "Add 5 Users..."

# 5.times do
#   user = Faker::Internet.user('username', 'email')
#   user.password = "123456"
#   User.create!(user)
# end

# puts "Add 5 Locations in 2 districts..."

# 5.times do
#   location = Location.new(
#     name: Faker::Restaurant.name,
#     address: Faker::Address.street_address,
#     district: ["Neukölln", "Kreuzberg"].sample,
#     zipcode: 10_997
#   )
#   location.save!
# end

puts "Add 5 books..."
file = File.read('test/test_books.json')
books = JSON.parse(file)

p books[0]['items']
