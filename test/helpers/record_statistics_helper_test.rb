require 'test_helper'

class RecordStatisticsHelperTest < ActionView::TestCase
  test 'check_division' do
    expected = '<span class="glyphicon glyphicon-check"></span>'
    assert_equal expected, check_division('str', String)
    expected = '<span class="glyphicon glyphicon-unchecked"></span>'
    assert_equal expected, check_division('str', Integer)
  end
end
