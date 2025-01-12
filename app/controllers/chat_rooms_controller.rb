# frozen_string_literal: true

class ChatRoomsController < ApplicationController
  def index
    @chat_rooms = current_user.chat_rooms.includes(:users, :messages).joins(:users)
    @current_user = current_user
    @unread = @chat_rooms.each_with_object({}) do |chat_room, counts|
      counts[chat_room.id] = chat_room.messages.where(read: false).where.not(user_id: current_user.id).count
    end
    @selected_chat = if params[:chat_room_id].present?
                       @chat_rooms.find_by(id: params[:chat_room_id])
                     else
                       @chat_rooms.first
                     end
    if @selected_chat
      @selected_chat.messages.where(read: false).where.not(user_id: current_user.id).update_all(read: true)
    else
      redirect_to root_path and return
    end
  end
end
