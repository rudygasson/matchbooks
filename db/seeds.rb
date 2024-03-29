users_with_avatar = {
  sebi: "https://ca.slack-edge.com/T02NE0241-U01112279QU-32e6c9d36a8d-512",
  oliver: "https://ca.slack-edge.com/T02NE0241-USL1K1LKA-94322c3f7d7c-512",
  thibault: "https://ca.slack-edge.com/T02NE0241-U016C685S3U-518502b630b9-192",
  nina: "https://ca.slack-edge.com/T02NE0241-U0160CHLQ14-c8e3ee5c6d61-512",
  pato: "https://ca.slack-edge.com/T02NE0241-U01BHAWKMDZ-5728ee214b68-512",
  rudy: "https://ca.slack-edge.com/T02NE0241-U03A9UJ0N49-8e2ce1267830-512",
  helio: "https://ca.slack-edge.com/T02NE0241-U03AP03SHAQ-cf140c035077-512",
  soma: "https://ca.slack-edge.com/T02NE0241-U039QMQ6022-b2463a4c9158-512",
  philipp: "https://ca.slack-edge.com/T02NE0241-U039QLUS77Y-f472821e2f94-512"
}

districts = [
  "Charlottenburg-Wilmersdorf",
  "Friedrichshain-Kreuzberg",
  "Lichtenberg",
  "Marzahn-Hellersdorf",
  "Mitte",
  "Neukölln",
  "Pankow",
  "Reinickendorf",
  "Spandau",
  "Steglitz-Zehlendorf",
  "Tempelhof-Schöneberg",
  "Treptow-Köpenick"
]

puts "Add #{users_with_avatar.count} Users..."
users_with_avatar.each do |key, value|
  User.create(
    username: key.capitalize,
    email: "#{key}@test.com",
    password: "123456",
    avatar: value
  )
end

puts "Add 3 Locations in Neukölln, 1 in Kreuzberg and 1 in Mitte..."
Location.create(
  name: "Heartspace Coffee",
  address: "Urbanstraße 70a, 10967 Berlin",
  district: "Neukölln",
  zipcode: 10_967
)
Location.create(
  name: "Café bRICK",
  address: "Lenaustraße 1, 12047 Berlin",
  district: "Neukölln",
  zipcode: 12_047
)
Location.create(
  name: "KulturCafé",
  address: "Friedelstraße 28, 12047 Berlin",
  district: "Neukölln",
  zipcode: 12_047
)
Location.create(
  name: "Books & Bagels",
  address: "Warschauer Str. 74, 10243 Berlin",
  district: "Friedrichshain-Kreuzberg",
  zipcode: 10_243
)
Location.create(
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
  2.times do
    location = Location.find(Location.ids.sample)
    user.locations << location unless user.locations.include? location
  end
end

puts "Connect users to books through copies..."
User.all.each do |user|
  2.times do
    book = Book.find(Book.ids.sample)
    user.books << book unless user.books.include? book
  end
end
