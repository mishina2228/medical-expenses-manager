class CreateHospitals < ActiveRecord::Migration[5.2]
  def change
    create_table :hospitals do |t|
      t.string :name, null: false, unique: true
      t.integer :expense, default: 0
      t.integer :transportation, default: 0
      t.timestamps
    end
  end
end
