class BooksController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]

  def show
    @book = Book.find(params[:id])
    authorize @book # authorize @book for pundit
    @search_district = params[:district]
    # get users that have the selected book
    @book_users = @book.users
    # match book users with selected district, e. g. "Neukölln"
    @locations = []
    @book_users.each do |book_user|
      @locations += book_user.locations.select { |location| location.district == @search_district}
    end
    # get distinct list of locations where users are willing to meet
    @locations_uniq = @locations.map { |location| location }.uniq
    # get distinct list of users that have the book and are willing to meet at the locations
    # @book_users_at_location = @locations_uniq.map { |location| location.users }
    # raise

    ###### params to parse #####
    # 1) copy_id
    # 2) location
  end
end
