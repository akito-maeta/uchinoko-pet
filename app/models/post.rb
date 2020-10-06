class Post < ApplicationRecord

  # アソシエーション
  belongs_to :user
  attachment :image
  has_many :hashtag_posts, dependent: :destroy
  has_many :hashtags, through: :hashtag_posts
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user

  #バリデーション
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 15 }
  validates :introduction, presence: true, length: { maximum: 200 }
  validates :image, presence: true

  #ハッシュタグ機能
  #作成時DBへのコミット直前に実施
  after_create do
    post = Post.find_by(id: self.id)
    hashtags = self.introduction.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    hashtags.uniq.map do |hashtag|
      #ハッシュタグは先頭の'#'を外した上で保存させる
      tag = Hashtag.find_or_create_by(hashname: hashtag.downcase.delete('#'))
      post.hashtags << tag
    end
  end

  #更新時DBへのコミット直前に実施
  before_update do
    post = Post.find_by(id: self.id)
    post.hashtags.clear
    hashtags = self.introduction.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    hashtags.uniq.map do |hashtag|
      tag = Hashtag.find_or_create_by(hashname: hashtag.downcase.delete('#'))
      post.hashtags << tag
    end
  end

  #いいねしているかどうか
  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end

end
