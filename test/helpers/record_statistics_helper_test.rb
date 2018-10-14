require 'test_helper'

class RecordStatisticsHelperTest < ActionView::TestCase
  def test_check_division
    assert_equal 'glyphicon-check', check_division('str', String)
    assert_equal 'glyphicon-unchecked', check_division('str', Integer)
  end
end
