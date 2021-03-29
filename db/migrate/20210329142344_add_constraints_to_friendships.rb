class AddConstraintsToFriendships < ActiveRecord::Migration[6.1]
  def change
    change_column_null :friendships, :user_id, false
    change_column_null :friendships, :friend_id, false
    add_index :friendships, [:user_id, :friend_id], unique: true
  end
end
