class MeetingsController < ApplicationController
  def new
    @deliverer = User.find(1)
    @receiver = current_user
    @location = Location.find(params[:location])
    @meeting = Meeting.new
    authorize @meeting
  end

  def create
    @meeting = Meeting.new(meeting_params)
    @meeting.location = @location
    authorize @meeting
    @handover = Handover.new

    redirect_to :root
  end

  private

  def meeting_params
    params.require(:meeting).permit(:date)
  end
end
