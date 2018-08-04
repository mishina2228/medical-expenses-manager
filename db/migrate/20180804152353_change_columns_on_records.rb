class ChangeColumnsOnRecords < ActiveRecord::Migration[5.2]
  def up
    change_column_null :records, :division_id, false, 0
    change_column_null :records, :person_id, false, 0
  end

  def down
    change_column_null :records, :division_id, true, nil
    change_column_null :records, :person_id, true, nil
  end
end
