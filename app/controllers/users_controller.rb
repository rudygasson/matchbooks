class UsersController < ApplicationController
  def show
    @user = current_user
    authorize @user # pundit
    @user_locations = UserLocation.where(user_id: @user)
    # raise
  end
end
