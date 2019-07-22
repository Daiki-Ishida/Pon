class Message < ApplicationRecord
  has_many :notifications, dependent: :destroy
  
  belongs_to :sender, class_name: "User", foreign_key: "sender_id"
  belongs_to :room

  validates :sender_id, presence: true
  validates :room_id, presence: true
  validates :content, presence: true
end
