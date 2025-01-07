class Message < ApplicationRecord
  belongs_to :user
  belongs_to :chat_room
  validates :content, presence: true
  after_create :send_notification_to_user

  def send_notification_to_user
    other_user = chat_room.users.where.not(id: user.id).first
    return unless other_user
    unread_count = chat_room.messages.where(read: false, user_id: user.id).count
    Rails.logger.info "Enviando notificação para o usuário #{other_user.id} com o número de mensagens não lidas #{unread_count}"
    NotificationsChannel.broadcast_to(other_user, {
      chat_room_id: chat_room.id,
      unread_count: unread_count,
      user_id: user.id,
      message: self,
    })
  end
end
