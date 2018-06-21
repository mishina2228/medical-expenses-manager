class AddIndexToDivisions < ActiveRecord::Migration[5.2]
  def change
    add_index :divisions, [:name, :type], unique: true
  end
end
