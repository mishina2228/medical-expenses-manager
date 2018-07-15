require 'test_helper'

class RecordTest < ActiveSupport::TestCase
  def setup
    @records = [records(:記録1), records(:記録2)]
  end

  def test_export_utf8
    csv_string = RecordCSV.export(@records, 'utf-8')
    assert_equal 'UTF-8', csv_string.encoding.to_s
    actual = CSV.parse(csv_string, headers: true)

    assert_equal RecordCSV::HEADERS, actual.headers.map(&:to_sym)
    assert_equal 2, actual.size

    @records.each_with_index do |record, i|
      assert_equal record.date.strftime('%Y-%m-%d'), actual[i]['date']
      assert_equal record.person.name, actual[i]['person_name']
      assert_equal record.division.model_name.human, actual[i]['division']
      assert_equal record.division.name, actual[i]['division_name']
      assert_equal record.cost.to_s, actual[i]['cost']
    end
  end

  def test_export_sjis
    csv_string = RecordCSV.export(@records, 'sjis')
    assert_equal 'Windows-31J', csv_string.encoding.to_s
    actual = CSV.parse(csv_string.encode('utf-8'), headers: true)

    assert_equal RecordCSV::HEADERS, actual.headers.map(&:to_sym)
    assert_equal 2, actual.size

    @records.each_with_index do |record, i|
      assert_equal record.date.strftime('%Y-%m-%d'), actual[i]['date']
      assert_equal record.person.name, actual[i]['person_name']
      assert_equal record.division.model_name.human, actual[i]['division']
      assert_equal record.division.name, actual[i]['division_name']
      assert_equal record.cost.to_s, actual[i]['cost']
    end
  end
end
