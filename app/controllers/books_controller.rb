class BooksController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]

  def show
    @book = Book.find(params[:id])
    authorize @book # authorize @book for pundit
    # get users that have the selected book, but ignore current_user
    @book_users = @book.users - [current_user]
    # match book users with selected district, e. g. "Neukölln"
    @locations = []
    # check if params[:district] was passed
    if params[:district].nil? || params[:district] == "All areas"
      @book_users.each do |book_user|
        @locations += book_user.locations
      end
    else
      @search_district = params[:district]
      @book_users.each do |book_user|
        @locations += book_user.locations.select { |location| location.district == @search_district }
      end
    end
    # get distinct list of locations where users are willing to meet
    @locations_uniq = @locations.map.uniq
    # select book users from book locations
    # @location_book_users = @locations_uniq.map { |location| location.users & @book_users }
    @location_book_users = []
    @locations_uniq.each do |location|
      @location_book_users += location.users & @book_users
    end
    # get distinct list of book users at book locations
    @location_book_users_uniq = @location_book_users.uniq
  end
end
