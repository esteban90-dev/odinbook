class AddConstraintsToNotifications < ActiveRecord::Migration[6.1]
  def change
    change_column_null :notifications, :user_id, false
    change_column_null :notifications, :message, false
  end
end
