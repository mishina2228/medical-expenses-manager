class CreateHospitalTransports < ActiveRecord::Migration[5.2]
  def change
    create_table :hospital_transports do |t|
      t.belongs_to :hospital, index: true
      t.belongs_to :transport, index: true
      t.integer :transport_cost, null: false, default: 0
      t.timestamps
    end
  end
end
