# frozen_string_literal: true

class AddChatRoomReferenceToMessages < ActiveRecord::Migration[7.0]
  def change
    add_reference :messages, :chat_room, null: false, foreign_key: true
  end
end
