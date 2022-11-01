# frozen_string_literal: true

require 'test_helper'

class HospitalTest < ActiveSupport::TestCase
  test 'validation of Hospital' do
    assert Hospital.new(valid_params).valid?

    assert Hospital.new(valid_params.merge(name: nil)).invalid?
  end

  test 'unique validation of Hospital' do
    transport = transports(:transport1)
    drugstore = drugstores(:drugstore1)
    hospital = hospitals(:hospital1)

    assert Hospital.new(name: transport.name).valid?
    assert Hospital.new(name: drugstore.name).valid?

    hospital_duplicate = Hospital.new(name: hospital.name)
    assert hospital_duplicate.invalid?

    assert hospital.destroy
    assert hospital.deleted_at.present?
    assert hospital_duplicate.valid?,
           'should not violate unique constraints when a record logically deleted'
  end

  def valid_params
    {name: :test_name}
  end
end
