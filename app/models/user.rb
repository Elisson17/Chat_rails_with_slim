# frozen_string_literal: true

class User < ApplicationRecord
  has_many :messages
  has_many :chat_room_users
  has_many :chat_rooms, through: :chat_room_users
  has_many :sent_invites, class_name: 'Invite', foreign_key: 'sender_id'
  has_many :received_invites, class_name: 'Invite', foreign_key: 'receiver_id'
  before_create :generate_unique_hash

  validates_uniqueness_of :email
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def generate_unique_hash
    self.invite_code = loop do
      hash = SecureRandom.hex(10)
      break hash unless User.exists?(invite_code: hash)
    end
  end
end
