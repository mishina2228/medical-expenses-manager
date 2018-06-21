class CreateHospitals < ActiveRecord::Migration[5.2]
  def change
    create_table :hospitals do |t|
      t.string :name, null: false, unique: true
      t.integer :expense, null: false, default: 0
      t.timestamps
    end
  end
end
