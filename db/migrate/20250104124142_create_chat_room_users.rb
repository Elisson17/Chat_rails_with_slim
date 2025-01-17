# frozen_string_literal: true

class CreateChatRoomUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :chat_room_users do |t|
      t.references :chat_room, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.datetime :joined_at, default: -> { 'CURRENT_TIMESTAMP' }

      t.timestamps
    end
  end
end
