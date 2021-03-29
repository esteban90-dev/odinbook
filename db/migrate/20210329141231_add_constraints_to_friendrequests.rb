class AddConstraintsToFriendrequests < ActiveRecord::Migration[6.1]
  def change
    change_column_null :friend_requests, :requestor_id, false
    change_column_null :friend_requests, :requestee_id, false
    add_index :friend_requests, [:requestor_id, :requestee_id], unique: true
  end
end
