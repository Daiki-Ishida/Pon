class User < ApplicationRecord
  attr_accessor :remember_token, :activation_token

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
  has_many :requests
  has_many :contracts
  has_many :active_notifications, class_name: 'Notification',
                                  foreign_key: :action_user_id,
                                  dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification',
                                   foreign_key: :notified_user_id,
                                   dependent: :destroy

  has_secure_password
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
  validates :email, presence: true,
                    length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  before_create :create_activation_digest

  geocoded_by :postal_address
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

  def other_users_within(input)
    array = []
    self.other_users.each do |other_user|
      lat = other_user.latitude
      lng = other_user.longitude
      distance = self.distance_to([lat,lng], units: :kms)
      if distance <= input
        array << other_user
      end
    end
    return array
  end

  # 自身指定の縄張りの範囲内の任意のオブジェクト（第一引数）を返す。
  def objects_within_territory(objects)
    array = []
    self.other_users.each do |other_user|
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

  # 自身がフォロー中のユーザーのフェレットまたはポストを返す。
  def followings_objects(objects)
    array = []
    self.followings.each do |following|
      if objects == "ferrets"
        following.ferrets.each do |ferret|
          array << ferret
        end
      elsif objects == "posts"
        following.posts.each do |post|
          array << post
        end
      end
    end
    return array
  end

  def self.search(search)
    return User.all unless search
    User.where(['name LIKE ?', "%#{search}%"])
  end

  def self.sorted_by(sort, current_user)
    return User.all if sort.empty?
    case  sort
      when "territory"
        current_user.objects_within_territory("users")
      when "followings"
        current_user.followings
    end
  end

  def has_contracts_as_owner?
    Contract.where(owner_id: self.id).present?
  end

  def contracts_as_owner
    if self.has_contracts_as_owner?
      contracts = Contract.where(owner_id: self.id)
    end
  end

  def has_contracts_as_sitter?
    Contract.where(sitter_id: self.id).present?
  end

  def contracts_as_sitter
    if self.has_contracts_as_sitter?
      contracts = Contract.where(sitter_id: self.id)
    end
  end

  def average_rate
    sum = 0
    self.contracts_as_sitter.each do |contract|
      sum += contract.review.rate
    end
    count = self.contracts_as_sitter.count
    average = sum / count
    return average
  end

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def authenticated?(activation_token)
    BCrypt::Password.new(self.activation_digest).is_password?(activation_token)
  end

  def activate
    self.update_attributes(activated: true, activated_at: Time.zone.now )
  end

  private
    def create_activation_digest
      self.activation_token  = User.new_token
      self.activation_digest = User.digest(self.activation_token)
    end

end
