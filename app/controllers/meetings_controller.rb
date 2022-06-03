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
    @copy = Copy.find(params[:copy])
    @deliverer = User.find(params[:deliverer])
    @location = Location.find(params[:location])

    @meeting = Meeting.new(meeting_params)
    @meeting.location = @location
    authorize @meeting

    # @handover = Handover.new({
    #   copy: @copy,
    #   status: :pending
    # })
    # authorize @handover

    # @handover.receiver = current_user
    # @handover.deliverer = @deliverer

    # if @meeting.save
    #   @handover.meeting = @meeting
    # else
    #   flash.alert = "meeting.save failed"
    # end

    if @meeting.save
      redirect_to root_path
      # redirect_to meetings_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def meeting_params
    params.require(:meeting).permit(:date, :time)
  end
end
