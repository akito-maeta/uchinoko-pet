class Post < ApplicationRecord

  belongs_to :user
  attachment :image
  acts_as_taggable
end
