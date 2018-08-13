require 'test_helper'

class DivisionTest < ActiveSupport::TestCase
  def test_division_names
    actual = Division.division_names
    expected = {
      'Drugstore' => '薬局',
      'Hospital' => '病院',
      'Transport' => '交通機関'
    }

    assert_equal expected, actual
  end
end
