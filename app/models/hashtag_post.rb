class HashtagPost < ApplicationRecord

  # アソシエーション
  belongs_to :post
  belongs_to :hashtag

  #バリデーション
  validates :hashtag_id, presence: true
  validates :post_id, presence: true
end
