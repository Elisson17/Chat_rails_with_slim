class MessagesOfChatChannel < ApplicationCable::Channel
  def subscribed
    puts "Subscribed to #{params[:chat_room_id]}"
    stream_for params[:chat_room_id]
  end

  def unsubscribed
    stop_all_streams
  end
end
