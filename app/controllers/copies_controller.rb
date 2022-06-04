require 'httparty'

class CopiesController < ApplicationController
  def index
    @user = current_user
    @copies = @user.copies
    @copies = policy_scope(Copy) # pundit
  end

  def new
    @book = Book.new
    authorize @book # pundit
  end

  def create
    # book_params
    isbn = book_params[:isbn] # e. g. 9780571290581
    # check if the isbn already exists in the DB
    book = Book.find_by isbn: isbn
    # if no isbn matches => get book info from google books API
    if book.nil?
      book = make_google_books_request(book_params, isbn)
    end
    # if no book was found via API => render :new
    if book.nil?
      @book = Book.new
      authorize @book # pundit
      render(:new, status: :unprocessable_entity)
    # if a book was found via API => create copy
    else
      # create copy
      @copy = Copy.new
      @copy.user = current_user
      @copy.book = book
      authorize @copy # pundit
      if @copy.save
        # redirect to user library
        redirect_to copies_path
      else
        render(:new, status: :unprocessable_entity)
      end
    end
  end

  def destroy
    @copy = Copy.find(params[:id])
    authorize @copy
    @copy.destroy
    # redirect to user library
    redirect_to copies_path, status: :see_other
  end

  private

  def make_google_books_request(book_params, isbn)
    # create new Book instance
    book = Book.new(book_params)
    # get json from Google Books API
    url = "https://www.googleapis.com/books/v1/volumes?q=isbn:#{isbn}&maxResults=1"
    response = HTTParty.get(url)
    # convert response to JSON
    result = response.parsed_response
    # if no isbn can be found
    if result['totalItems'] > 0
      # extract book parameters
      book.title = result["items"][0]["volumeInfo"]["title"]
      book.author = result["items"][0]["volumeInfo"]["authors"][0]
      book.description = result["items"][0]["volumeInfo"]["description"]
      book.year = result["items"][0]["volumeInfo"]["publishedDate"].slice(0, 4).to_i
      if result["items"][0]["volumeInfo"]["imageLinks"].nil?
        book.thumbnail = "https://www.salonlfc.com/wp-content/uploads/2018/01/image-not-found-scaled-1150x647.png"
        book.cover_image = "https://www.salonlfc.com/wp-content/uploads/2018/01/image-not-found-scaled-1150x647.png"
      else
        book.thumbnail = result["items"][0]["volumeInfo"]["imageLinks"]["thumbnail"]
        id = result["items"][0]["id"]
        book.cover_image = "https://books.google.com/books/content/images/frontcover/#{id}?fife=w480-h960"
      end
      # clarify if we want to add genre / category
      # book.category = result["items"][0]["volumeInfo"]["categories"][0]
      book
    else
      nil
    end
  end

  def book_params
    params.require(:book).permit(
      :isbn,
      :title,
      :author,
      :description,
      :year,
      :thumbnail,
      :cover_image
    )
  end
end
