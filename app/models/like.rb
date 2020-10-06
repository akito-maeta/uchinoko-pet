class Like < ApplicationRecord

  # アソシエーション
  belongs_to :post
  belongs_to :user

  # バリデーション
  validates :user_id, presence: true
  validates :post_id, presence: true
end
