class User < ApplicationRecord
  has_many :ferrets, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :active_relationships, class_name: 'Relationship',
                                  foreign_key: :follower_id,
                                  dependent: :destroy
  has_many :passive_relationships, class_name: 'Relationship',
                                   foreign_key: :followed_id,
                                   dependent: :destroy
  has_many :followings, through: 'active_relationships', source: 'followed'
  has_many :followers, through: 'passive_relationships', source: 'follower'
  has_many :messages
  has_many :rooms, dependent: :destroy

  # 性別/画像/自己紹介は無しでも登録できる。
  validates :kanji_lastname, presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]/ }
  validates :kanji_firstname, presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]/ }
  validates :kana_lastname, presence: true, format: { with: /\A[ァ-ヶー－]+\z/ }
  validates :kana_firstname, presence: true, format: { with: /\A[ァ-ヶー－]+\z/ }
  validates :name, presence: true, length: { in: 1..16 }
  validates :birth_date, presence: true
  validates :postal_code, presence: true, length: { is: 7 }
  validates :postal_address, presence: true

  # 対象のユーザーをフォローしていればtrueを返す。
  def follows?(other_user)
    followings.include?(other_user)
  end
end
