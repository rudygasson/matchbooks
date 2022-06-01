module BookDataHelper
  def self.extract_book(gdata)
    book = Book.new
    g_id = gdata["items"][0]["id"]
    vol = gdata["items"][0]["volumeInfo"]
    book.isbn = vol["industryIdentifiers"][0]["identifier"]
    book.title = vol["title"]
    book.author = vol["authors"][0]
    book.description = vol["description"]
    book.year = vol["publishedDate"].slice(0, 4).to_i
    book.thumbnail = vol["imageLinks"]["thumbnail"]
    book.cover_image = "https://books.google.com/books/content/images/frontcover/#{g_id}?fife=w480-h960"
    book
  end
end
