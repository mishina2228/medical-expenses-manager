require 'test_helper'

class HospitalTest < ActiveSupport::TestCase
  def test_validation
    hospital = Hospital.new(valid_params)
    assert hospital.valid?
    assert hospital.save

    hospital = Hospital.new(valid_params.merge(name: nil))
    assert hospital.invalid?
  end

  def test_unique_validation
    hospital = hospitals(:病院1)
    transport = transports(:交通機関1)
    drugstore = drugstores(:薬局1)

    hospital_duplicate = Hospital.new(name: hospital.name)
    assert hospital_duplicate.invalid?

    hospital_unique = Hospital.new(name: transport.name)
    assert hospital_unique.valid?

    hospital_unique = Hospital.new(name: drugstore.name)
    assert hospital_unique.valid?
  end

  def valid_params
    {name: :test_name}
  end
end
