class Contract < ApplicationRecord
  has_many :reports, dependent: :destroy
  has_one :review

  belongs_to :owner, class_name: "User", foreign_key: "owner_id"
  belongs_to :sitter, class_name: "User", foreign_key: "sitter_id"

  validates :owner_id, presence: true
  validates :sitter_id, presence: true
  validates :start_at, presence: true
  validates :end_at, presence: true
  validates :fee, presence: true
  validates :memo, presence: true
end
