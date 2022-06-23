class Friendship < ApplicationRecord
  attr_accessor :inviting_friend_id, :accepting_friend_id

  belongs_to :inviter, :class_name => 'User', :foreign_key => :inviting_friend_id
  belongs_to :accepter, :class_name => 'User', :foreign_key => :accepting_friend_id
  
  scope :pending, -> { where(status: 'pending') }
  scope :accepted, -> { where(status: 'accepted') }
  scope :by_inviter, ->(user) { where(inviter: user) }
  scope :by_accepter, ->(user) { where(accepter: user) }
end
