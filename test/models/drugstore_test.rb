# frozen_string_literal: true

require 'test_helper'

class DrugstoreTest < ActiveSupport::TestCase
  test 'validation of Drugstore' do
    assert Drugstore.new(valid_params).valid?

    assert Drugstore.new(valid_params.merge(name: nil)).invalid?
  end

  test 'unique validation of Drugstore' do
    hospital = hospitals(:hospital1)
    transport = transports(:transport1)
    drugstore = drugstores(:drugstore1)

    assert Drugstore.new(name: hospital.name).valid?
    assert Drugstore.new(name: transport.name).valid?

    drugstore_duplicate = Drugstore.new(name: drugstore.name)
    assert drugstore_duplicate.invalid?

    assert drugstore.destroy
    assert drugstore.deleted_at.present?
    assert drugstore_duplicate.valid?,
           'should not violate unique constraints when a record logically deleted'
  end

  def valid_params
    {name: :test_name}
  end
end
