class AddDeletedAtToHospitalTransports < ActiveRecord::Migration[5.2]
  def change
    add_column :hospital_transports, :deleted_at, :datetime
    add_index :hospital_transports, :deleted_at
  end
end
