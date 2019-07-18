class Contract < ApplicationRecord
  has_one :report
  has_one :review

  validates :owner_id, presence: true
  validates :sitter_id, presence: true
  validates :start_at, presence: true
  validates :end_at, presence: true
  validates :fee, presence: true
  validates :memo, presence: true
end
