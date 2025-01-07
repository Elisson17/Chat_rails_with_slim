class MessagesController < ApplicationController
  before_action :set_chat_room

  def create
    @message = @chat_room.messages.new(message_params)
    @message.user = current_user

    if @message.save
      MessagesOfChatChannel.broadcast_to(@chat_room.id, message: @message)
    else
      Rails.logger.info "Não foi possível enviar a mensagem."
    end
  end

  private

  def set_chat_room
    @chat_room = current_user.chat_rooms.find_by(id: params[:chat_room_id])
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
