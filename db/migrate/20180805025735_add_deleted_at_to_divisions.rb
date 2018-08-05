class AddDeletedAtToDivisions < ActiveRecord::Migration[5.2]
  def change
    add_column :divisions, :deleted_at, :datetime
    add_index :divisions, :deleted_at
  end
end
