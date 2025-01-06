class User < ApplicationRecord
  has_many :messages
  has_many :chat_room_users
  has_many :chat_rooms, through: :chat_room_users

  validates_uniqueness_of :email
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end