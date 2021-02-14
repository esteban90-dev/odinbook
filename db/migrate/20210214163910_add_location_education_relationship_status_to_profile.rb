class AddLocationEducationRelationshipStatusToProfile < ActiveRecord::Migration[6.1]
  def change
    add_column :profiles, :location, :string 
    add_column :profiles, :education, :string
    add_column :profiles, :relationship_status, :string
  end
end
