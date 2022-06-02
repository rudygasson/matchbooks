class UsersController < ApplicationController
  def show
    @user = current_user
    authorize @user # pundit
    @user_locations = UserLocation.where(user_id: @user)
    @locations = Location.all
    @locations_of_user = @locations.where(id: @user_locations.map(&:location_id))
    # The `geocoded` scope filters only locations with coordinates
    @markers = @locations_of_user.geocoded.map do |location|
      {
        lat: location.latitude,
        lng: location.longitude
      }
    end
  end
end
