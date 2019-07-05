class Post < ApplicationRecord
  has_many :comments
  belongs_to :user

  validates :title, presence: true
  validates :content, presence: true
end
