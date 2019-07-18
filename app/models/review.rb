class Review < ApplicationRecord
  belongs_to :contract

  validates :rate, presence: true, numericality: {less_than_or_equal_to: 5}
end
