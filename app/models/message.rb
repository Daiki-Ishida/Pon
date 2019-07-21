class Message < ApplicationRecord
  belongs_to :sender, class_name: "User", foreign_key: "sender_id"
  belongs_to :room

  validates :sender_id, presence: true
  validates :room_id, presence: true
  validates :content, presence: true

  def self.send_notice(model, content)
    room = Room.find_room(model.owner_id, model.sitter_id)
    Message.create!(
      sender_id: sender.id,
      room_id: room.id,
      content: content
    )
  end
end
