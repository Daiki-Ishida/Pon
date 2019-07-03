class User < ApplicationRecord
  has_many :ferrets, dependent: :destroy

  # 性別/画像/自己紹介は無しでも登録できる。
  validates :kanji_lastname, presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]/ }
  validates :kanji_firstname, presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]/ }
  validates :kana_lastname, presence: true, format: { with: /\A[ァ-ヶー－]+\z/ }
  validates :kana_firstname, presence: true, format: { with: /\A[ァ-ヶー－]+\z/ }
  validates :name, presence: true, length: { in: 1..16 }
  validates :birth_date, presence: true
  validates :postal_code, presence: true, length: { is: 7 }
  validates :postal_address, presence: true
end
