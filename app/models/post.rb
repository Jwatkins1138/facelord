class Post < ApplicationRecord
  
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :post_likes
  has_many :post_likers, :through => :post_likes, :source => :user

end
