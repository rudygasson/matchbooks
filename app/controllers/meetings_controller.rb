class MeetingsController < ApplicationController
  def index
    @meetings = policy_scope(Meeting).includes(:location, handovers: :deliverer)
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
      @handover = Handover.new
      @handover.meeting = @meeting
      @handover.copy = @copy
      @handover.receiver = current_user
      @handover.deliverer = @deliverer
      if @handover.save
        redirect_to meetings_path
      else
        flash.alert = "Error - Saving of handover failed"
        render :new, status: :unprocessable_entity
      end
    else
      flash.alert = "Error - Saving of meeting failed"
      render :new, status: :unprocessable_entity
    end
  end

  private

  def meeting_params
    params.require(:meeting).permit(:date, :time)
  end
end
