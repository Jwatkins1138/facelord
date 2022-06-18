class CreateFriendships < ActiveRecord::Migration[7.0]
  def change
    create_table :friendships do |t|

      t.timestamps
      t.integer :inviting_friend_id
      t.integer :accepting_friend_id
    end

    add_index(:friendships, [:inviting_friend_id, :accepting_friend_id], :unique => true )
    add_index(:friendships, [:accepting_friend_id, :inviting_friend_id], :unique => true )

  end
end
