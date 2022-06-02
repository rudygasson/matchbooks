class BooksController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]

  def show
    @book = Book.find(params[:id])
    authorize @book # authorize @book for pundit
    # get users that have the selected book
    @book_users = @book.users
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
    @locations_uniq = @locations.map { |location| location }.uniq
  end
end
