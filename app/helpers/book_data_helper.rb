module BookDataHelper
  def self.extract_book(gdata, book_params = nil)
    g_id = gdata["items"][0]["id"]
    vol = gdata["items"][0]["volumeInfo"]
    if book_params.nil?
      book = Book.new
      book.isbn = vol["industryIdentifiers"][0]["identifier"]
    else
      book = Book.new(book_params)
    end
    book.title = vol["title"]
    book.author = vol["authors"][0]
    if vol["description"] != nil
      book.description = vol["description"].gsub("�", " ")
    end
    book.year = vol["publishedDate"].slice(0, 4).to_i
    if vol["imageLinks"].nil?
      book.thumbnail = "https://static.wikia.nocookie.net/deathmarch/images/6/60/No_Image_Available.png"
      book.cover_image = "https://static.wikia.nocookie.net/deathmarch/images/6/60/No_Image_Available.png"
    else
      book.thumbnail = vol["imageLinks"]["thumbnail"]
      book.cover_image = "https://books.google.com/books/content/images/frontcover/#{g_id}?fife=w480-h960"
    end
    book
  end
end
