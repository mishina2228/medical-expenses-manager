require 'test_helper'

class HospitalTest < ActiveSupport::TestCase
  test 'validation of Hospital' do
    hospital = Hospital.new(valid_params)
    assert hospital.valid?

    hospital = Hospital.new(valid_params.merge(name: nil))
    assert hospital.invalid?
  end

  test 'unique validation of Hospital' do
    hospital = hospitals(:hospital1)
    transport = transports(:transport1)
    drugstore = drugstores(:drugstore1)

    hospital_duplicate = Hospital.new(name: hospital.name)
    assert hospital_duplicate.invalid?

    hospital_unique = Hospital.new(name: transport.name)
    assert hospital_unique.valid?

    hospital_unique = Hospital.new(name: drugstore.name)
    assert hospital_unique.valid?

    assert hospital.destroy
    assert hospital.deleted_at.present?
    assert hospital_duplicate.valid?,
           'should not violate unique constraints when a record logically deleted'
  end

  def valid_params
    {name: :test_name}
  end
end
