class MeetingsController < ApplicationController
  def show
    @meeting = Meeting.find(params[:id])
    authorize @meeting # authorize @meeting for pundit
    # @handover = Handover.find(params[:id])
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
      # only after a meeting was saved, we can assign a meeting_id to handover
      @handover = Handover.new
      @handover.meeting_id = @meeting.id
      @handover.copy_id = @copy.id
      @handover.receiver_id = current_user.id
      @handover.deliverer_id = @deliverer.id
      if @handover.save
        redirect_to meeting_path(@meeting)
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
