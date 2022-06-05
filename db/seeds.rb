puts "Add 5 Users..."
5.times do
  User.create!(Faker::Internet.user('username', 'email').merge(password: "123456"))
end

puts "Add 3 Locations in Neukölln, 1 in Kreuzberg and 1 in Mitte..."
# 4.times do
#   Location.create!(
#     name: Faker::Restaurant.name,
#     address: Faker::Address.street_address,
#     district: "Neukölln",
#     zipcode: 12_043
#   )
# end
Location.create!(
  name: "Heartspace Coffee",
  address: "Urbanstraße 70a, 10967 Berlin",
  district: "Neukölln",
  zipcode: 10_967
)
Location.create!(
  name: "Café bRICK",
  address: "Lenaustraße 1, 12047 Berlin",
  district: "Neukölln",
  zipcode: 12_047
)
Location.create!(
  name: "KulturCafé",
  address: "Friedelstraße 28, 12047 Berlin",
  district: "Neukölln",
  zipcode: 12_047
)
Location.create!(
  name: "Books & Bagels",
  address: "Warschauer Str. 74, 10243 Berlin",
  district: "Friedrichshain-Kreuzberg",
  zipcode: 10_243
)
Location.create!(
  name: "LeWagon",
  address: "Rudi-Dutschke-Straße 26, 10969 Berlin",
  district: "Mitte",
  zipcode: 10_969
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

puts "Connect users to books through copies..."
User.all.each do |user|
  4.times do
    book = Book.find(Book.ids.sample)
    user.books << book unless user.books.include? book
  end
end
