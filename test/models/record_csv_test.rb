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
      assert_equal record.division.model_name, actual[i]['division']
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
      assert_equal record.division.model_name, actual[i]['division']
      assert_equal record.division.name, actual[i]['division_name']
      assert_equal record.cost.to_s, actual[i]['cost']
    end
  end

  def test_load_csv_utf8
    records = RecordCSV.load(csv_path('test_utf8.csv'), 'utf-8')
    records.each_with_index do |record, i|
      assert_equal RecordCSV, record.class
      assert_equal csv_expect_data[i][:date], record.date
      assert_equal csv_expect_data[i][:person_name], record.person_name
      assert_equal csv_expect_data[i][:division], record.division
      assert_equal csv_expect_data[i][:division_name], record.division_name
      assert_equal csv_expect_data[i][:cost], record.cost
    end
  end

  def test_load_csv_sjis
    records = RecordCSV.load(csv_path('test_sjis.csv'), 'sjis')
    records.each_with_index do |record, i|
      assert_equal RecordCSV, record.class
      assert_equal csv_expect_data[i][:date], record.date
      assert_equal csv_expect_data[i][:person_name], record.person_name
      assert_equal csv_expect_data[i][:division], record.division
      assert_equal csv_expect_data[i][:division_name], record.division_name
      assert_equal csv_expect_data[i][:cost], record.cost
    end
  end

  def test_invalid_header
    e = assert_raise ArgumentError do
      RecordCSV.load(csv_path('test_utf8_missing_headers.csv'), 'utf-8')
    end
    assert_equal I18n.t('helpers.notice.load_csv.invalid_headers'), e.message

    e = assert_raise ArgumentError do
      RecordCSV.load(csv_path('test_utf8_invalid_values.csv'), 'utf-8')
    end
    assert_equal I18n.t('helpers.notice.load_csv.invalid_headers'), e.message
  end

  def test_encode_discordance
    e = assert_raise ArgumentError do
      RecordCSV.load(csv_path('test_sjis.csv'), 'utf-8')
    end
    assert_equal I18n.t('helpers.notice.load_csv.encoding_error.sjis_to_utf8'), e.message

    e = assert_raise ArgumentError do
      RecordCSV.load(csv_path('test_utf8.csv'), 'sjis')
    end
    assert_equal I18n.t('helpers.notice.load_csv.encoding_error.utf8_to_sjis'), e.message

  end

  def csv_expect_data
    [
      {
        date: '2018-06-05',
        person_name: 'person1',
        division: 'Hospital',
        division_name: 'hospital1',
        cost: 3200
      },
      {
        date: '2018-06-24',
        person_name: 'ユーザー2',
        division: 'Hospital',
        division_name: '病院2',
        cost: 200
      }
    ]
  end

  def csv_path(file)
    Rails.root.join('test', 'data', file)
  end
end
