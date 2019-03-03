require 'test_helper'

class HospitalTransportTest < ActiveSupport::TestCase
  def test_validation
    ht = HospitalTransport.new(valid_params)
    assert ht.valid?

    ht = HospitalTransport.new(valid_params.merge(transport_cost: nil))
    assert ht.invalid?

    ht = HospitalTransport.new(valid_params.merge(transport_cost: 'abc'))
    assert ht.invalid?
    ht = HospitalTransport.new(valid_params.merge(transport_cost: 5.2))
    assert ht.invalid?
    ht = HospitalTransport.new(valid_params.merge(transport_cost: -1))
    assert ht.invalid?
    ht = HospitalTransport.new(valid_params.merge(transport_cost: 0))
    assert ht.valid?
  end

  def test_unique_validation
    HospitalTransport.destroy_all
    ht1 = HospitalTransport.new(valid_params)
    assert ht1.valid?
    assert ht1.save

    hospital2 = hospitals(:病院2)
    ht2 = HospitalTransport.new(valid_params.merge(hospital_id: hospital2.id))
    assert ht2.valid?

    ht3 = HospitalTransport.new(valid_params.merge(transport_cost: 300))
    assert ht3.invalid?

    assert_nil ht1.deleted_at
    assert ht1.destroy
    assert ht1.deleted_at.present?
    assert ht3.valid?, '論理削除した場合はユニーク制約の対象外'
  end

  def valid_params
    hospital = hospitals(:病院1)
    transport = transports(:交通機関1)
    {hospital_id: hospital.id, transport_id: transport.id, transport_cost: 100}
  end
end
