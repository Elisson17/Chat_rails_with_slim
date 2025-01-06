class ChatRoomsController < ApplicationController
  def index
    @chat_rooms = current_user.chat_rooms.includes(:users, :messages).joins(:users)
    @current_user = current_user
    @selected_chat = if params[:chat_id].present?
      @chat_rooms.find_by(id: params[:chat_id])
    else
      @chat_rooms.first
    end
  end
end
