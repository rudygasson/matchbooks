class MeetingsController < ApplicationController
  def index
    @meetings = policy_scope(Meeting)
    @handovers = []
    @meetings.each do |meeting|
      @handovers += meeting.handovers
    end
  end

  def new
    @copy = Copy.find(params[:copy])
    @deliverer = @copy.user
    @receiver = current_user
    @location = Location.find(params[:location])
    @meeting = Meeting.new
    authorize @meeting
  end

  def create
    @copy = Copy.find(params[:copy])
    @deliverer = User.find(params[:deliverer])
    @location = Location.find(params[:location])
    @meeting = Meeting.new(meeting_params)
    @meeting.location = @location
    authorize @meeting

    if @meeting.save
      redirect_to meetings_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def meeting_params
    params.require(:meeting).permit(:date, :time)
  end
end
