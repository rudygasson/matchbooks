# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

puts "Add 5 Users..."
5.times do
  user = Faker::Internet.user('username', 'email')
  user = User.new(user)
  user.password = "123456"
  user.save!
end

puts "Add 5 Locations in Neukölln and 1 in Kreuzberg..."
5.times do
  location = Location.new(
    name: Faker::Restaurant.name,
    address: Faker::Address.street_address,
    district: "Neukölln",
    zipcode: 12_043
  )
  location.save!
end
Location.create!(
  name: Faker::Restaurant.name,
  address: Faker::Address.street_address,
  district: "Kreuzberg",
  zipcode: 10_997
)

puts "Add books from test_books.json ..."
file = File.read('test/test_books.json')
test_books = JSON.parse(file)

test_books.each do |test_book|
  book = BookDataHelper.extract_book(test_book)
  book.save
end
