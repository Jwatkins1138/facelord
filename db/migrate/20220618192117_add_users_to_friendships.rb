class AddUsersToFriendships < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :friendships, :users, column: :inviting_friend_id
    add_foreign_key :friendships, :users, column: :accepting_friend_id
  end
end
