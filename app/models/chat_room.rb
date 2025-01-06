class ChatRoom < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_many :chat_room_users, dependent: :destroy
  has_many :users, through: :chat_room_users

  validates :room_type, inclusion: { in: %w[group direct] }
end
