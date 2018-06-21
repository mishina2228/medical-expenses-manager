require 'test_helper'

class PatientTest < ActiveSupport::TestCase
  def test_validation
    patient = Patient.new(valid_params)
    assert patient.valid?

    patient = Patient.new(valid_params.merge(name: nil))
    assert patient.invalid?

    patient = Patient.new(valid_params.merge(relationship: nil))
    assert patient.invalid?
  end

  def valid_params
    {name: :test_name, relationship: :test_relationship}
  end
end
