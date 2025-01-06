class MessagesOfChatChannel < ApplicationCable::Channel
  def subscribed
    chat_room  = ChatRoom.find_by(id: params[:chat_room_id])
    stream_for chat_room
  end

  def unsubscribed
    stop_all_streams
  end
end
