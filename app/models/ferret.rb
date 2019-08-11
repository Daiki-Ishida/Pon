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

  def siblings
    self.user.ferrets.where.not(id: self.id)
  end

  def self.sorted_by(sort, user)
    return Ferret.all if sort.empty?
    case sort
      when "territory"
        user.objects_within_territory("ferrets")
      when "followings"
        user.followings_objects("ferrets")
    end
  end
end
