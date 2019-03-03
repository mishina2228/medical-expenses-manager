class AddUniqueIndexToHospitalTransport < ActiveRecord::Migration[5.2]
  def change
    add_index :hospital_transports, [:transport_id, :hospital_id, :deleted_at], unique: true, name: :index_hospital_transports_on_3columns
  end
end
