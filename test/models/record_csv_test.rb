# frozen_string_literal: true

require 'test_helper'

class RecordCsvTest < ActiveSupport::TestCase
  def setup
    @records = [records(:record1), records(:record2)]
  end

  test 'validation' do
    assert RecordCSV.new(record_csv_params).valid?
  end

  test 'validation of date' do
    assert RecordCSV.new(record_csv_params.merge(date: nil)).invalid?
    assert RecordCSV.new(record_csv_params.merge(date: 'aabbccdd')).invalid?
    assert RecordCSV.new(record_csv_params.merge(date: '2018-08-32')).invalid?
  end

  test 'validation of person_name' do
    assert RecordCSV.new(record_csv_params.merge(person_name: nil)).invalid?
  end

  test 'validation of division' do
    assert RecordCSV.new(record_csv_params.merge(division: nil)).invalid?
    assert RecordCSV.new(record_csv_params.merge(division: 'NotExist')).invalid?

    assert RecordCSV.new(record_csv_params.merge(division: 'Hospital')).valid?
    assert RecordCSV.new(record_csv_params.merge(division: 'Drugstore')).valid?
    assert RecordCSV.new(record_csv_params.merge(division: 'Transport')).valid?
  end

  test 'validation of division_name' do
    assert RecordCSV.new(record_csv_params.merge(division_name: nil)).invalid?
  end

  test 'validation of cost' do
    assert RecordCSV.new(record_csv_params.merge(cost: nil)).invalid?
    assert RecordCSV.new(record_csv_params.merge(cost: 1.5)).invalid?
    assert RecordCSV.new(record_csv_params.merge(cost: -1)).invalid?
    assert RecordCSV.new(record_csv_params.merge(cost: 0)).valid?
  end

  test 'export as utf8' do
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

  test 'export as sjis' do
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

  test 'load csv as utf8' do
    records = RecordCSV.load(csv_path('test_utf8.csv'))
    records.each_with_index do |record, i|
      assert_equal RecordCSV, record.class
      assert_equal csv_expect_data[i][:date], record.date
      assert_equal csv_expect_data[i][:person_name], record.person_name
      assert_equal csv_expect_data[i][:division], record.division
      assert_equal csv_expect_data[i][:division_name], record.division_name
      assert_equal csv_expect_data[i][:cost], record.cost
    end
  end

  test 'load csv as sjis' do
    records = RecordCSV.load(csv_path('test_sjis.csv'))
    records.each_with_index do |record, i|
      assert_equal RecordCSV, record.class
      assert_equal csv_expect_data[i][:date], record.date
      assert_equal csv_expect_data[i][:person_name], record.person_name
      assert_equal csv_expect_data[i][:division], record.division
      assert_equal csv_expect_data[i][:division_name], record.division_name
      assert_equal csv_expect_data[i][:cost], record.cost
    end
  end

  test 'load csv as euc' do
    records = RecordCSV.load(csv_path('test_euc.csv'))
    records.each_with_index do |record, i|
      assert_equal RecordCSV, record.class
      assert_equal csv_expect_data[i][:date], record.date
      assert_equal csv_expect_data[i][:person_name], record.person_name
      assert_equal csv_expect_data[i][:division], record.division
      assert_equal csv_expect_data[i][:division_name], record.division_name
      assert_equal csv_expect_data[i][:cost], record.cost
    end
  end

  test 'csv invalid header' do
    e = assert_raise ArgumentError do
      RecordCSV.load(csv_path('test_utf8_missing_headers.csv'))
    end
    assert_equal I18n.t('helpers.notice.load_csv.invalid_headers'), e.message

    e = assert_raise ArgumentError do
      RecordCSV.load(csv_path('test_utf8_invalid_values.csv'))
    end
    assert_equal I18n.t('helpers.notice.load_csv.invalid_headers'), e.message
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
    Rails.root.join('test/data', file)
  end

  def record_csv_params
    {
      date: '2018-08-13',
      person_name: 'Mike',
      division: 'Hospital',
      division_name: 'hospital1',
      cost: 100
    }
  end
end
