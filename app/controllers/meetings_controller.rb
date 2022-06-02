class MeetingsController < ApplicationController
  def new
    @copy = Copy.find(params[:copy])
    @deliverer = @copy.user
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
