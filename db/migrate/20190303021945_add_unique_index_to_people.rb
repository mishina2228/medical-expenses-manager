class AddUniqueIndexToPeople < ActiveRecord::Migration[5.2]
  def change
    add_index :people, [:name, :relationship, :deleted_at], unique: true
  end
end
