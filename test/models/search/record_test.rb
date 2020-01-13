require 'test_helper'

class Search::RecordTest < ActiveSupport::TestCase
  setup do
    @r1 = records(:record1)
    @r2 = records(:record2)
    @r3 = records(:record3)
    @r4 = records(:record4)
    @r5 = records(:record5)
  end

  test 'search by id' do
    search = Search::Record.new(ids: @r1.id)
    actual = search.search
    assert_equal 1, actual.size
    assert_includes actual, @r1
  end

  test 'search by person' do
    person = people(:user1)
    search = Search::Record.new(name: person.id)
    actual = search.search
    assert_includes actual, @r1
    assert_includes actual, @r2
    assert_not_includes actual, @r3
    assert_not_includes actual, @r4
    assert_not_includes actual, @r5
  end

  test 'search only hospital' do
    search = Search::Record.new(division_type: 'Hospital')
    actual = search.search
    assert_includes actual, @r1
    assert_includes actual, @r2
    assert_not_includes actual, @r3
    assert_not_includes actual, @r4
    assert_not_includes actual, @r5
  end

  test 'search only drugstore' do
    search = Search::Record.new(division_type: 'Drugstore')
    actual = search.search
    assert_not_includes actual, @r1
    assert_not_includes actual, @r2
    assert_includes actual, @r3
    assert_not_includes actual, @r4
    assert_not_includes actual, @r5
  end

  test 'search only transport' do
    search = Search::Record.new(division_type: 'Transport')
    actual = search.search
    assert_not_includes actual, @r1
    assert_not_includes actual, @r2
    assert_not_includes actual, @r3
    assert_includes actual, @r4
    assert_includes actual, @r5
  end

  test 'search by division' do
    hospital = hospitals(:hospital1)
    search = Search::Record.new(division_id: hospital.id)
    actual = search.search
    assert_includes actual, @r1
    assert_not_includes actual, @r2
    assert_not_includes actual, @r3
    assert_not_includes actual, @r4
    assert_not_includes actual, @r5
  end

  test 'search by from date' do
    date = Time.zone.today - 1.day
    search = Search::Record.new(from_date: date)
    actual = search.search
    assert_includes actual, @r1
    assert_includes actual, @r2
    assert_not_includes actual, @r3
    assert_not_includes actual, @r4
    assert_not_includes actual, @r5
  end

  test 'search by to date' do
    date = Time.zone.today - 1.day
    search = Search::Record.new(to_date: date)
    actual = search.search
    assert_not_includes actual, @r1
    assert_includes actual, @r2
    assert_includes actual, @r3
    assert_includes actual, @r4
    assert_includes actual, @r5
  end

  test 'search by month' do
    assert @r1.update(date: Time.zone.parse('2020-01-13') )
    search = Search::Record.new(month: '2020-01')
    actual = search.search
    assert_includes actual, @r1

    assert @r1.update(date: Time.zone.parse('2020-02-13') )
    actual = search.search
    assert_not_includes actual, @r1
  end

  test 'days_of_month' do
    record = Search::Record.new(month: '2018-02')
    expected = Time.new(2018, 2, 1)..Time.new(2018, 2, 28).end_of_day
    assert_equal expected, record.days_of_month
  end
end
