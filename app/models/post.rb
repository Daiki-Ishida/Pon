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

  def self.sorted_by(sort, user)
    return Post.all if sort.empty?
    case  sort
      when "territory"
        user.objects_within_territory("posts")
      when "followings"
        user.followings_objects("posts")
    end
  end

end
