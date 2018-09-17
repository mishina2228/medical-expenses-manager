require 'test_helper'

class HospitalTransportTest < ActiveSupport::TestCase
  def test_validation
    hospital_transport = HospitalTransport.new(valid_params)
    assert hospital_transport.valid?

    hospital_transport = HospitalTransport.new(valid_params.merge(transport_cost: nil))
    assert hospital_transport.invalid?

    hospital_transport = HospitalTransport.new(valid_params.merge(transport_cost: 'abc'))
    assert hospital_transport.invalid?
    hospital_transport = HospitalTransport.new(valid_params.merge(transport_cost: 5.2))
    assert hospital_transport.invalid?
    hospital_transport = HospitalTransport.new(valid_params.merge(transport_cost: -1))
    assert hospital_transport.invalid?
    hospital_transport = HospitalTransport.new(valid_params.merge(transport_cost: 0))
    assert hospital_transport.valid?
  end

  def valid_params
    hospital = hospitals(:病院1)
    transport = transports(:交通機関1)
    {hospital_id: hospital.id, transport_id: transport.id, transport_cost: 100}
  end
end
