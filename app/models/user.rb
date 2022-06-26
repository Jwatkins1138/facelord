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
  
                 
  def pending_invite_friends
    (invited_friends.joins(:friendships).merge(Friendship.pending))
  end

  def confirmed_invite_friends
    (invited_friends.joins(:friendships).merge(Friendship.accepted))
  end

  def pending_accept_friends
    (accepted_friends.joins(:friendships).merge(Friendship.pending))
  end

  def confirmed_accept_friends
    (accepted_friends.joins(:friendships).merge(Friendship.accepted))
  end

  def friends
    (confirmed_invite_friends + confirmed_accept_friends).flatten.uniq
  end

  def feed
    (self.friends << self)
  end

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


end
