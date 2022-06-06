class ChatroomChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    p "-------------> Chatroom-ID = #{params[:id]}"
    @chatroom = Chatroom.find(params[:id])
    stream_for @chatroom
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
