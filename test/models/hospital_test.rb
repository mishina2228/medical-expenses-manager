require 'test_helper'

class HospitalTest < ActiveSupport::TestCase
  def test_validation
    hospital = Hospital.new(valid_params)
    assert hospital.valid?

    hospital = Hospital.new(valid_params.merge(name: nil))
    assert hospital.invalid?

    hospital = Hospital.new(valid_params.merge(expense: nil))
    assert hospital.invalid?
    hospital = Hospital.new(valid_params.merge(expense: -1))
    assert hospital.invalid?
    hospital = Hospital.new(valid_params.merge(expense: 3.14))
    assert hospital.invalid?
  end

  def valid_params
    {name: :test_name, expense: 100}
  end
end
