class Message < ApplicationRecord
  has_many :notifications, dependent: :destroy

  belongs_to :sender, class_name: "User", foreign_key: "sender_id"
  belongs_to :room

  validates :sender_id, presence: true
  validates :room_id, presence: true
  validates :content, presence: true

  def create_notification(user, room)
    notification = user.active_notifications.build(
      message_id: self.id,
      notified_user_id: room.opponent(user).id,
      action: "message"
    )
    notification.save if notification.valid?
  end
end
