class Message < ApplicationRecord
  belongs_to :sender, class_name: "User", foreign_key: "sender_id"
  belongs_to :room

  validates :user_id, presence: true
  validates :room_id, presence: true
  validates :content, presence: true
end
