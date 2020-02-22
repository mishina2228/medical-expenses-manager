require 'test_helper'

class TransportTest < ActiveSupport::TestCase
  test 'validation of Transport' do
    transport = Transport.new(valid_params)
    assert transport.valid?

    transport = Transport.new(valid_params.merge(name: nil))
    assert transport.invalid?
  end

  test 'unique validation of Transport' do
    hospital = hospitals(:hospital1)
    transport = transports(:transport1)
    drugstore = drugstores(:drugstore1)

    transport_unique = Transport.new(name: hospital.name)
    assert transport_unique.valid?

    transport_duplicate = Transport.new(name: transport.name)
    assert transport_duplicate.invalid?

    transport_unique = Transport.new(name: drugstore.name)
    assert transport_unique.valid?

    assert transport.destroy
    assert transport.deleted_at.present?
    assert transport_duplicate.valid?,
           'should not violate unique constraints when a record logically deleted'
  end

  def valid_params
    {name: :test_name}
  end
end
