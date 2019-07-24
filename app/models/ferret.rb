class Ferret < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  # 人間と異なり性別は必須とした。
  validates :name, presence: true
  validates :birth_date, presence: true
  validates :gender, presence: true
  validates :user_id, presence: true

  def self.search(search)
    return Ferret.all unless search
    Ferret.where(['name LIKE ?', "%#{search}%"])
  end

  def owned_by?(user)
    self.user == user
  end

  def self.on_hiring
    array = []
    User.where(status: 2).each do |user|
      user.ferrets.each do |ferret|
        array << ferret
      end
    end
    return array
  end
end
