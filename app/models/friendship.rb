class Friendship < ApplicationRecord
  attr_accessor :inviting_friend_id, :accepting_friend_id

  belongs_to :user, :foreign_key => :inviting_friend_id
  belongs_to :user, :foreign_key => :accepting_friend_id
end
