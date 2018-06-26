class AddNameRelationshipToPeople < ActiveRecord::Migration[5.2]
  def change
    add_index :people, [:name, :relationship], unique: true
  end
end
