class AddUniqueIndexToDivisions < ActiveRecord::Migration[5.2]
  def change
    add_index :divisions, [:name, :type, :deleted_at], unique: true
  end
end
