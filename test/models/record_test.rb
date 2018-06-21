require 'test_helper'

class RecordTest < ActiveSupport::TestCase
  def test_validation
    record = Record.new(valid_params)
    p record
    assert record.valid?

    record = Record.new(valid_params.merge(date: nil))
    assert record.invalid?

    record = Record.new(valid_params.merge(cost: nil))
    assert record.invalid?
    record = Record.new(valid_params.merge(cost: -1))
    assert record.invalid?
    record = Record.new(valid_params.merge(cost: 3.14))
    assert record.invalid?
  end

  def valid_params
    hospital1 = hospitals(:病院1)
    patient1 = patients(:患者1)
    {date: Time.zone.today, cost: 100,
     hospital_id: hospital1.id, patient_id: patient1.id}
  end
end
