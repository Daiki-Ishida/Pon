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
  has_many :rooms
  has_many :requests, dependent: :destroy
  has_many :contracts

  has_one_attached :image

  # 性別/画像/自己紹介は無しでも登録できる。
  validates :kanji_lastname, presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]/ }
  validates :kanji_firstname, presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]/ }
  validates :kana_lastname, presence: true, format: { with: /\A[ァ-ヶー－]+\z/ }
  validates :kana_firstname, presence: true, format: { with: /\A[ァ-ヶー－]+\z/ }
  validates :name, presence: true, length: { in: 1..16 }
  validates :birth_date, presence: true
  validates :postal_code, presence: true, length: { is: 7 }
  validates :postal_address, presence: true

  geocoded_by :postal_address
  after_validation :geocode, if: :postal_address_changed?
  acts_as_mappable :default_units => :kms,
                   :lat_column_name => :latitude,
                   :lng_column_name => :longitude


  # 対象のユーザーをフォローしていればtrueを返す。
  def follows?(other_user)
    followings.include?(other_user)
  end

  # 対象のユーザー以外の全ユーザーを返す。
  def other_users
    User.where.not(id: self.id)
  end

  # 自身指定の縄張りの範囲内の任意のオブジェクト（第一引数）を返す。
  def objects_within_territory(objects, other_users)
    array = []
    other_users.each do |other_user|
      lat = other_user.latitude
      lng = other_user.longitude
      distance = self.distance_to([lat,lng], units: :kms)
      if distance <= self.territory
        if objects == "users"
          array << other_user
        elsif objects == "ferrets"
          other_user.ferrets.each do |ferret|
            array << ferret
          end
        elsif objects == "posts"
          other_user.posts.each do |post|
            array << post
          end
        end
      end
    end
    return array
  end

  # 自身がフォロー中のユーザーのポストを返す。
  def folliowngs_posts
    array = []
    self.followings.each do |following|
      following.posts.each do |post|
        array << post
      end
    end
    return array
  end
end
