class User < ApplicationRecord

  
  has_many :posts
  has_many :comments
  has_many :post_likes
  has_many :liked_posts, :through => :post_likes, :source => :post
  has_many :friendships, :foreign_key => :accepting_friend_id
  has_many :friendships, :foreign_key => :inviting_friend_id 

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
  
                 

  def friends
    (invited_friends.joins(:friendships).merge(Friendship.accepted) + accepted_friends.joins(:friendships).merge(Friendship.accepted)).flatten.uniq
  end

  def feed
    (self.friends << self)
  end

  def pending_invite_friends
    (invited_friends.joins(:friendships).merge(Friendship.pending))
  end

  def pending_accept_friends
    (accepted_friends.joins(:friendships).merge(Friendship.pending))
  end


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


end
