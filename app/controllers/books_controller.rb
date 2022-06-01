class BooksController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]

  def show
    @book = Book.find(params[:id])
    authorize @book # authorize @book for pundit
    # @book = Book.last # FOR TESTING => delete late
    district = "Friedrichshain"
    @locations = Location.where("district = ?", "#{district}")

    ## AREA 51 ##
    # @location_condition = @locations.map.with_index() { |_, index| "location_id = #{index}" }.join(" OR ")
    # # get instances of ULs that are in the area
    # @user_locations = UserLocation.where(@location_condition)
    # # create array with users that are in the area
    # @user_array = @user_locations.map { |ul| ul.user_id }.uniq
    # @user_condition = @user_array.map.with_index(1) { |_, index| "user_id = #{index}" }.join(" OR ")
    # # find users with copies that are in the area
    # @user_copies_in_area = Copy.where(@user_condition)
    # # find users with copies that are in the areaand have the book of interest
  end
end
