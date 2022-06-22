class User < ApplicationRecord

  # has_many :invited_friendships, :foreign_key => :inviting_friend_id,
  #          :class_name => 'Friendship'
  # has_many :invited_friends, :through => :invited_friendships,
  #          :source => :accepted
  # has_many :accepted_friendships, :foreign_key => :accepting_friend_id,
  #          :class_name => 'Friendship'
  # has_many :accepted_friends, :through => :accepted_friendships,
  #          :source => :invited 
  
  
  has_many :posts
  has_many :comments
  has_many :post_likes
  has_many :liked_posts, :through => :post_likes, :source => :post
  has_many :friendships, :foreign_key => :inviting_friend_id 
  has_many :friendships, :foreign_key => :accepting_friend_id 

  has_and_belongs_to_many :invited_friends,
                class_name: 'User',
                join_table: :friendships,
                foreign_key: :inviting_friend_id,
                association_foreign_key: :accepting_friend_id


  has_and_belongs_to_many :accepted_friends,
                class_name: 'User',
                join_table: :friendships,
                foreign_key: :accepting_friend_id,
                association_foreign_key: :inviting_friend_id              
  
  # scope :accepted, joins(:friendships).merge(Friendship.accepted)

  def friends
    (invited_friends.joins(:friendships).merge(Friendship.accepted) + accepted_friends.joins(:friendships).merge(Friendship.accepted)).flatten.uniq
  end


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
