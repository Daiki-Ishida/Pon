class Post < ApplicationRecord
  has_many :comments
  has_many :likes
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
end
