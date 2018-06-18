class CreateRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :records do |t|
      t.belongs_to :hospital, index: true
      t.belongs_to :patient, index: true
      t.date :date, null: false
      t.integer :cost, null: false, default: 0
      t.timestamps
    end
  end
end
