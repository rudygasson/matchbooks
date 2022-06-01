class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @search_district = params[:district]
    @search_term = params[:query]
    sql_query = "title ILIKE :query OR author ILIKE :query"
    if @search_term
      @filtered_by_query = Book.where(sql_query, query: "%#{@search_term}%")
      @filtered_books = @filtered_by_query.select { |book| book_districts(book).include?(search_district.downcase) }
    end

    # if @search_term.nil?
    #   @filtered_books = @filtered_by_query.select { |book| book_districts(book).include?("neukölln") }
    # end
  end

  private

  def book_districts(book)
    users = book.users
    locations = []
    users.each do |user|
      locations += user.locations
    end
    districts = locations.map { |location| location.district.downcase }
    return districts
  end
end
