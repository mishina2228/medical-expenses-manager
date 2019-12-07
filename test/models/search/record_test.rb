require 'test_helper'

class Search::RecordTest < ActiveSupport::TestCase
  test 'days_of_month' do
    record = Search::Record.new(month: '2018-02')
    expected = Time.new(2018, 2, 1)..Time.new(2018, 2, 28).end_of_day
    assert_equal expected, record.days_of_month
  end
end
