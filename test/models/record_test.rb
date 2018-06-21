require 'test_helper'

class RecordTest < ActiveSupport::TestCase
  def test_validation
    record = Record.new(valid_params)
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
    person1 = people(:ユーザー1)
    {date: Time.zone.today, cost: 100,
     division_id: hospital1.id, person_id: person1.id}
  end
end
