# frozen_string_literal: true

require 'test_helper'

class RecordStatisticsHelperTest < ActionView::TestCase
  test 'check_division' do
    expected = '<span class="far fa-check-square"></span>'
    assert_equal expected, check_division('str', String)
    expected = '<span class="far fa-square"></span>'
    assert_equal expected, check_division('str', Integer)
  end
end
