require 'test_helper'

class DrugstoreTest < ActiveSupport::TestCase
  def test_validation
    drugstore = Drugstore.new(valid_params)
    assert drugstore.valid?
    assert drugstore.save

    drugstore = Drugstore.new(valid_params.merge(name: nil))
    assert drugstore.invalid?
  end

  def test_unique_validation
    hospital = hospitals(:病院1)
    transport = transports(:交通機関1)
    drugstore = drugstores(:薬局1)

    drugstore_unique = Drugstore.new(name: hospital.name)
    assert drugstore_unique.valid?

    drugstore_unique = Drugstore.new(name: transport.name)
    assert drugstore_unique.valid?

    drugstore_duplicate = Drugstore.new(name: drugstore.name)
    assert drugstore_duplicate.invalid?
  end

  def valid_params
    {name: :test_name}
  end
end
