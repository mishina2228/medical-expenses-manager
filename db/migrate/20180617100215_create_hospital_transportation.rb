class CreateHospitalTransportation < ActiveRecord::Migration[5.2]
  def change
    create_table :hospital_transportation do |t|
      t.belongs_to :hospital, index: true
      t.belongs_to :transportation, index: true
      t.timestamps
    end
  end
end
