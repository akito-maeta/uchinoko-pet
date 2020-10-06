class Hashtag < ApplicationRecord

  # アソシエーション
  has_many :hashtag_posts, dependent: :destroy
  has_many :posts, through: :hashtag_posts

  #バリデーション
  validates :hashname, presence: true
end
