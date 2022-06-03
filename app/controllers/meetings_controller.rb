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

    @copy = meeting_params[:copy]
    @deliverer = meeting_params[:deliverer]

    @handover = Handover.new({
      copy: @copy,
      receiver_id: current_user,
      deliverer: @deliverer,
      status: :pending
    })
    authorize @handover

    if @meeting.save
      @handover.meeting = @meeting
      redirect_to meetings_path(@meeting, @handover) if @handover.save
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def meeting_params
    params.require(:meeting).permit(:date, :time, :copy, :deliverer)
  end
end
