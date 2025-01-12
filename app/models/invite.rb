# frozen_string_literal: true

class Invite < ApplicationRecord
  belongs_to :sender, class_name: 'User', foreign_key: 'sender_id'
  belongs_to :receiver, class_name: 'User', foreign_key: 'receiver_id'


  validates :status, inclusion: { in: %w[pending accepted declined] }

  scope :pending, -> { where(status: 'pending') }
end
