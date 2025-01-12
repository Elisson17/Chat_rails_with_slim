# frozen_string_literal: true

class MessagesOfChatChannel < ApplicationCable::Channel
  def subscribed
    stream_for params[:chat_room_id]
  end

  def unsubscribed
    stop_all_streams
  end
end
