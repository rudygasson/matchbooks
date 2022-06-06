module BookDataHelper
  def self.extract_book(gdata, book_params = nil)
    if book_params.nil?
      book = Book.new
    else
      book = Book.new(book_params)
    end
    g_id = gdata["items"][0]["id"]
    vol = gdata["items"][0]["volumeInfo"]
    book.isbn = vol["industryIdentifiers"][0]["identifier"]
    book.title = vol["title"]
    book.author = vol["authors"][0]
    book.description = vol["description"]
    book.year = vol["publishedDate"].slice(0, 4).to_i
    if vol["imageLinks"].nil?
      book.thumbnail = "https://www.salonlfc.com/wp-content/uploads/2018/01/image-not-found-scaled-1150x647.png"
      book.cover_image = "https://www.salonlfc.com/wp-content/uploads/2018/01/image-not-found-scaled-1150x647.png"
    else
      book.thumbnail = vol["imageLinks"]["thumbnail"]
      book.cover_image = "https://books.google.com/books/content/images/frontcover/#{g_id}?fife=w480-h960"
    end
    book
  end
end
