class ChangeColumnsOnHospitalTransports < ActiveRecord::Migration[5.2]
  def up
    change_column_null :hospital_transports, :hospital_id, false, 0
    change_column_null :hospital_transports, :transport_id, false, 0
  end

  def down
    change_column_null :hospital_transports, :hospital_id, true, nil
    change_column_null :hospital_transports, :transport_id, true, nil
  end
end
