require 'test_helper'

class RecordStatisticsHelperTest < ActionView::TestCase
  def test_check_division
    expected = '<span class="glyphicon glyphicon-check"></span>'
    assert_equal expected, check_division('str', String)
    expected = '<span class="glyphicon glyphicon-unchecked"></span>'
    assert_equal expected, check_division('str', Integer)
  end
end
