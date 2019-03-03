class RemoveNameRelationshipIndexFromPeople < ActiveRecord::Migration[5.2]
  def change
    remove_index :people, column: [:name, :relationship]
  end
end
