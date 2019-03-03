class RemoveNameTypeIndexFromDivisions < ActiveRecord::Migration[5.2]
  def change
    remove_index :divisions, column: [:name, :type]
  end
end
