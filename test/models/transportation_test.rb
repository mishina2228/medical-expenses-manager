require 'test_helper'

class TransportationTest < ActiveSupport::TestCase
  def test_validation
    transportation = Transportation.new(valid_params)
    assert transportation.valid?

    transportation = Transportation.new(valid_params.merge(name: nil))
    assert transportation.invalid?
  end

  def valid_params
    {name: :test_name}
  end
end
