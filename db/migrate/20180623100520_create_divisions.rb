class CreateDivisions < ActiveRecord::Migration[5.2]
  def change
    create_table :divisions do |t|
      t.string :name, null: false, unique: true
      t.string :type, null: false, index: true
      t.timestamps
    end
  end
end
