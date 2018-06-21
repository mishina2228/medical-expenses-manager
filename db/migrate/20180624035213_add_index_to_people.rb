class AddIndexToPeople < ActiveRecord::Migration[5.2]
  def change
    add_index :people, :name, unique: true
  end
end
