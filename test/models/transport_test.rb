require 'test_helper'

class TransportTest < ActiveSupport::TestCase
  def test_validation
    transport = Transport.new(valid_params)
    assert transport.valid?
    assert transport.save

    transport = Transport.new(valid_params.merge(name: nil))
    assert transport.invalid?
  end

  def test_unique_validation
    hospital = hospitals(:病院1)
    transport = transports(:交通機関1)
    drugstore = drugstores(:薬局1)

    transport_unique = Transport.new(name: hospital.name)
    assert transport_unique.valid?

    transport_duplicate = Transport.new(name: transport.name)
    assert transport_duplicate.invalid?

    transport_unique = Transport.new(name: drugstore.name)
    assert transport_unique.valid?
  end

  def valid_params
    {name: :test_name}
  end
end
