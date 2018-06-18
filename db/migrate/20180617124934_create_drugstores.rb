class CreateDrugstores < ActiveRecord::Migration[5.2]
  def change
    create_table :drugstores do |t|
      t.belongs_to :hospital, index: true
      t.string :name, null: false, unique: true
      t.timestamps
    end
  end
end
