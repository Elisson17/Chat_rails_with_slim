# frozen_string_literal: true

class CreateInvites < ActiveRecord::Migration[7.0]
  def change
    create_table :invites do |t|
      t.integer :sender_id, null: false
      t.integer :receiver_id, null: false
      t.string :status, default: 'pending', null: false # Status: pending, accepted, declined

      t.timestamps

      t.index :sender_id
      t.index :receiver_id

      t.foreign_key :users, column: :sender_id
      t.foreign_key :users, column: :receiver_id
    end
  end
end
