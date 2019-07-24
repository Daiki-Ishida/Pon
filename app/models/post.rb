class Post < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :notifications, dependent: :destroy

  belongs_to :user

  has_one_attached :image

  # validates :title, presence: true
  validates :content, presence: true

  def likes?(user)
    likes.where(user_id: user.id).exists?
  end

  def self.search(search)
    return Post.all unless search
    Post.where(['content LIKE ?', "%#{search}%"])
  end

  def create_notification(user, action)
    notification = user.active_notifications.build(
      post_id: self.id,
      notified_user_id: self.user.id,
      action: action
    )
    notification.save if notification.valid?
  end

  def self.on_hiring
    array = []
    User.where(status: 1).each do |user|
      user.posts.each do |post|
        array << post
      end
    end
    return array
  end


end
