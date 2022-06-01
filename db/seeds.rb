puts "Add 5 Users..."
5.times do
  User.create!(Faker::Internet.user('username', 'email'), password: "123456")
end

puts "Add 4 Locations in Neukölln and 1 in Kreuzberg..."
4.times do
  Location.create!(
    name: Faker::Restaurant.name,
    address: Faker::Address.street_address,
    district: "Neukölln",
    zipcode: 12_043
  )
end
Location.create!(
  name: Faker::Restaurant.name,
  address: Faker::Address.street_address,
  district: "Kreuzberg",
  zipcode: 10_997
)

puts "Add books from test_books.json..."
file = File.read('test/test_books.json')
test_books = JSON.parse(file)

test_books.each do |test_book|
  book = BookDataHelper.extract_book(test_book)
  book.save
end

puts "Connect users to random locations..."
User.all.each do |user|
  3.times do
    location = Location.find(Location.ids.sample)
    user.locations << location unless user.locations.include? location
  end
end
