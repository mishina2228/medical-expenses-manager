# frozen_string_literal: true

require 'test_helper'

class HospitalTransportTest < ActiveSupport::TestCase
  test 'validation of HospitalTransport' do
    HospitalTransport.destroy_all

    assert HospitalTransport.new(valid_params).valid?

    assert HospitalTransport.new(valid_params.merge(transport_cost: nil)).invalid?
    assert HospitalTransport.new(valid_params.merge(transport_cost: 'abc')).invalid?
    assert HospitalTransport.new(valid_params.merge(transport_cost: 5.2)).invalid?
    assert HospitalTransport.new(valid_params.merge(transport_cost: -1)).invalid?
    assert HospitalTransport.new(valid_params.merge(transport_cost: 0)).valid?
  end

  test 'unique validation of HospitalTransport' do
    HospitalTransport.destroy_all
    ht1 = HospitalTransport.new(valid_params)
    assert ht1.valid?
    assert ht1.save

    hospital2 = hospitals(:hospital2)
    ht2 = HospitalTransport.new(valid_params.merge(hospital_id: hospital2.id))
    assert ht2.valid?

    ht3 = HospitalTransport.new(valid_params.merge(transport_cost: 300))
    assert ht3.invalid?
    assert_includes ht3.errors[:transport_id], I18n.t('errors.messages.duplicate')

    assert_nil ht1.deleted_at
    assert ht1.destroy
    assert ht1.deleted_at.present?
    assert ht3.valid?, 'should not violate unique constraints when a record logically deleted'
  end

  def valid_params
    hospital = hospitals(:hospital1)
    transport = transports(:transport1)
    {hospital_id: hospital.id, transport_id: transport.id, transport_cost: 100}
  end
end
