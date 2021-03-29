class AddConstraintsToProfiles < ActiveRecord::Migration[6.1]
  def change
    change_column_null :profiles, :user_id, false
    change_column_null :profiles, :location, false
    change_column_null :profiles, :relationship_status, false
    change_column_null :profiles, :education, false
  end
end
