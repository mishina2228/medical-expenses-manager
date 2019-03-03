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

  def valid_params
    hospital = hospitals(:病院1)
    transport = transports(:交通機関1)
    {hospital_id: hospital.id, transport_id: transport.id, transport_cost: 100}
  end
end
