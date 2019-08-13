class Contact < ApplicationRecord
  validates :email, presence: true,
                    length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  validates :content, presence: true
  validates :subject, presence: true
  validates :status, presence: true
end
