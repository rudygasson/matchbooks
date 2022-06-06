class MessagesController < ApplicationController
  def create
    @meeting = Meeting.find(params[:meeting_id])
    @chatroom = Chatroom.find_by(meeting_id: @meeting)
    @message = Message.new(message_params)
    @message.chatroom = @chatroom
    @message.user = current_user
    authorize @message
    # raise
    if @message.save
      ChatroomChannel.broadcast_to(
        @chatroom,
        render_to_string(partial: "message", locals: { message: @message })
      )
      head :ok
    else
      render "meetings/show", status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
