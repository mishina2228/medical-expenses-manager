# frozen_string_literal: true

require 'test_helper'

class TransportTest < ActiveSupport::TestCase
  test 'validation of Transport' do
    assert Transport.new(valid_params).valid?

    assert Transport.new(valid_params.merge(name: nil)).invalid?
  end

  test 'unique validation of Transport' do
    hospital = hospitals(:hospital1)
    drugstore = drugstores(:drugstore1)
    transport = transports(:transport1)

    assert Transport.new(name: hospital.name).valid?
    assert Transport.new(name: drugstore.name).valid?

    transport_duplicate = Transport.new(name: transport.name)
    assert transport_duplicate.invalid?

    assert transport.destroy
    assert transport.deleted_at.present?
    assert transport_duplicate.valid?,
           'should not violate unique constraints when a record logically deleted'
  end

  def valid_params
    {name: :test_name}
  end
end
