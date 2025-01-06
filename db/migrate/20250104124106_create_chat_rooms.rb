class CreateChatRooms < ActiveRecord::Migration[7.0]
  def change
    create_table :chat_rooms do |t|
      t.string :name
      t.string :room_type, null: false

      t.timestamps
    end
  end
end
