require 'test_helper'

module Search
  class RecordTest < ActiveSupport::TestCase
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

    test 'search by from_date passing a String' do
      search = Search::Record.new(from_date: Date.yesterday.to_s)
      actual = search.search
      assert_includes actual, @r1
      assert_includes actual, @r2
      assert_not_includes actual, @r3
      assert_not_includes actual, @r4
      assert_not_includes actual, @r5
    end

    test 'search by from_date passing a Date' do
      search = Search::Record.new(from_date: Date.yesterday)
      actual = search.search
      assert_includes actual, @r1
      assert_includes actual, @r2
      assert_not_includes actual, @r3
      assert_not_includes actual, @r4
      assert_not_includes actual, @r5
    end

    test 'search by from_date - a wrong argument should be ignored' do
      [nil, true, false, '', 'test', '2018-13-20'].each do |arg|
        search = Search::Record.new(from_date: arg)
        actual = search.search
        assert_includes actual, @r1
        assert_includes actual, @r2
        assert_includes actual, @r3
        assert_includes actual, @r4
        assert_includes actual, @r5
      end
    end

    test 'search by to_date passing a String' do
      search = Search::Record.new(to_date: Date.yesterday.to_s)
      actual = search.search
      assert_not_includes actual, @r1
      assert_includes actual, @r2
      assert_includes actual, @r3
      assert_includes actual, @r4
      assert_includes actual, @r5
    end

    test 'search by to_date passing a Date' do
      search = Search::Record.new(to_date: Date.yesterday)
      actual = search.search
      assert_not_includes actual, @r1
      assert_includes actual, @r2
      assert_includes actual, @r3
      assert_includes actual, @r4
      assert_includes actual, @r5
    end

    test 'search by to_date - a wrong argument should be ignored' do
      [nil, false, true, '', 'test', '2018-13-20'].each do |arg|
        search = Search::Record.new(to_date: arg)
        actual = search.search
        assert_includes actual, @r1
        assert_includes actual, @r2
        assert_includes actual, @r3
        assert_includes actual, @r4
        assert_includes actual, @r5
      end
    end

    test 'search by month' do
      assert @r1.update(date: Date.parse('2020-01-13'))
      search = Search::Record.new(month: '2020-01')
      actual = search.search
      assert_includes actual, @r1

      assert @r1.update(date: Date.parse('2020-02-13'))
      actual = search.search
      assert_not_includes actual, @r1
    end

    test 'days_of_month' do
      record = Search::Record.new(month: '2018-02')
      expected = Date.new(2018, 2, 1)..Date.new(2018, 2, 28)
      assert_equal expected, record.days_of_month
    end

    test 'from_date returns a Date' do
      expected = Date.new(2018, 10, 20)
      ['2018-10-20', '2018-10-20 01:23:45', '2018-10-20T01:23:45+0900'].each do |arg|
        record = Search::Record.new(from_date: arg)
        assert_equal expected, record.from_date
      end
    end

    test 'from_date returns nil when passing a wrong argument' do
      [nil, false, true, '', 'test', '2018-13-20'].each do |arg|
        record = Search::Record.new(from_date: arg)
        assert_nil record.from_date
      end
    end

    test 'to_date returns a Date' do
      expected = Date.new(2018, 12, 20)
      ['2018-12-20', '2018-12-20 01:23:45', '2018-12-20T01:23:45+0900'].each do |arg|
        record = Search::Record.new(to_date: arg)
        assert_equal expected, record.to_date
      end
    end

    test 'to_date returns nil when passing a wrong argument' do
      [nil, false, true, '', 'test', '2018-13-20'].each do |arg|
        record = Search::Record.new(to_date: arg)
        assert_nil record.to_date
      end
    end

    test 'date returns nil or Range' do
      channel = Search::Record.new
      assert_nil channel.date

      channel = Search::Record.new(from_date: '2018-10-19')
      assert_equal channel.from_date.., channel.date

      channel = Search::Record.new(to_date: '2018-12-19')
      assert_equal (..channel.to_date), channel.date

      channel = Search::Record.new(from_date: '2018-10-19', to_date: '2018-12-19')
      assert_equal channel.from_date..channel.to_date, channel.date
    end
  end
end
