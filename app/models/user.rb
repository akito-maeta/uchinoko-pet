class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # バリデーション
  validates :name, presence: true, length: { maximum: 20 }
  validates :pet_name, presence: true, length: { maximum: 20 }
  validates :introduction, length: { maximum: 200 }
  validates :address, length: { maximum: 200 }

  # アソシエーション
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  attachment :image
  has_many :liked_posts, through: :likes, source: :post
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy # フォローしている人を取得
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy # フォローされている人を取得
  has_many :following_user, through: :follower, source: :followed # 自分がフォローしている人
  has_many :followers_user, through: :followed, source: :follower # 自分をフォローしている人

  #geocodeで使用
  geocoded_by :address
  after_validation :geocode

  # ユーザーをフォローする
  def follow(user_id)
    follower.create(followed_id: user_id)
  end

  # ユーザーのフォローを外す
  def unfollow(user_id)
    follower.find_by(followed_id: user_id).destroy
  end

  # フォロー確認をおこない、フォローしていればtrueを返す
  def following?(user)
    following_user.include?(user)
  end


  def self.guest
    find_or_create_by!(name: 'ゲストさん', pet_name: 'ゲスト', email: 'guest@guest.work', address: '新宿御苑') do |user|
      user.password = SecureRandom.urlsafe_base64
    end
  end
end
