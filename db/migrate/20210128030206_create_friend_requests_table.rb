class CreateFriendRequestsTable < ActiveRecord::Migration[6.1]
  def change
    create_table :friend_requests do |t|
      t.integer :requestor_id
      t.integer :requestee_id

      t.timestamps
    end
  end
end
