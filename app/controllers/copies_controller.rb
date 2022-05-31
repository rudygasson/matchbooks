require 'httparty'

class CopiesController < ApplicationController
  def index
    @user = current_user
    @copies = @user.copies
  end

  def new
    @book = Book.new
  end

  def create
    isbn = params[:book][:isbn]
    # check if the isbn already exists in the DB
    book = Book.find_by isbn: isbn
    # if no isbn matches => add the book to books and copies table
    if book.nil?
      # create new Book instance
      book = Book.new(book_params)
      # get json from Google Books API
      url = "https://www.googleapis.com/books/v1/volumes?q=isbn:#{isbn}&maxResults=1"
      response = HTTParty.get(url)
      # convert response to JSON
      result = response.parsed_response
      # extract book parameters
      book.title = result["items"][0]["volumeInfo"]["title"]
      book.author = result["items"][0]["volumeInfo"]["authors"][0]
      book.description = result["items"][0]["volumeInfo"]["description"]
      book.year = result["items"][0]["volumeInfo"]["publishedDate"].slice(0, 4).to_i
      book.thumbnail = result["items"][0]["volumeInfo"]["imageLinks"]["thumbnail"]
      id = result["items"][0]["id"]
      book.cover_image = "https://books.google.com/books/content/images/frontcover/#{id}?fife=w480-h960"
      # clarify if we want to add genre / category
      # book.category = result["items"][0]["volumeInfo"]["categories"][0]
      # create copy
      @copy = Copy.new
      @copy.user = current_user
      @copy.book = book
      if @copy.save
        # redirect to user library
        redirect_to copies_path
      else
        render(:new, status: :unprocessable_entity)
      end
    # if isbn matches => add the book to copies table
    else
      # create copy
      @copy = Copy.new
      @copy.user = current_user
      @copy.book = book
      if @copy.save
        # redirect to user library
        redirect_to copies_path
      else
        render(:new, status: :unprocessable_entity)
      end
    end
  end

  private

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
