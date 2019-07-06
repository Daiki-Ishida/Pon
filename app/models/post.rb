class Post < ApplicationRecord
  has_many :comments
  has_many :likes
  belongs_to :user

  validates :title, presence: true
  validates :content, presence: true

  def likes?(user)
    like = false
    if user.present?
      like = likes.where(user_id: user.id).exists?
    end
    return like
  end
end
