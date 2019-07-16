class Ferret < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  # 人間と異なり性別は必須とした。
  validates :name, presence: true
  validates :birth_date, presence: true
  validates :gender, presence: true
  validates :user_id, presence: true
end
