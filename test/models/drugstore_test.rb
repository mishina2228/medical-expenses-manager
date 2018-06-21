require 'test_helper'

class DrugstoreTest < ActiveSupport::TestCase
  def test_validation
    drugstore = Drugstore.new(valid_params)
    drugstore.save!
    assert drugstore.valid?

    drugstore = Drugstore.new(valid_params.merge(name: nil))
    assert drugstore.invalid?
  end

  def valid_params
    hospital1 = hospitals(:病院1)
    {name: :test_name, hospital_id: hospital1.id}
  end
end
