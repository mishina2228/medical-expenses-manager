require 'test_helper'

class DrugstoreTest < ActiveSupport::TestCase
  def test_validation
    drugstore = Drugstore.new(valid_params)
    assert drugstore.valid?

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

    assert drugstore.destroy
    assert drugstore.deleted_at.present?
    assert drugstore_duplicate.valid?, '論理削除した場合はユニーク制約の対象外'
  end

  def valid_params
    {name: :test_name}
  end
end
