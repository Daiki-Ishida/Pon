class Room < ApplicationRecord
  has_many :messages
  belongs_to :owner, class_name: "User", foreign_key: "owner_id"
  belongs_to :guest, class_name: "User", foreign_key: "guest_id"

  validates :owner_id, presence: true
  validates :guest_id, presence: true
end
