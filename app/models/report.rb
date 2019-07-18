class Report < ApplicationRecord
  belongs_to :contract

  has_one_attached :image

  validates :content, presence: true
end
