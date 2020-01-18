require 'test_helper'

class RecordTest < ActiveSupport::TestCase
  test 'validation' do
    record = Record.new(valid_params)
    assert record.valid?

    record = Record.new(valid_params.merge(date: nil))
    assert record.invalid?

    record = Record.new(valid_params.merge(cost: nil))
    assert record.invalid?
    record = Record.new(valid_params.merge(cost: -1))
    assert record.invalid?
    record = Record.new(valid_params.merge(cost: 3.14))
    assert record.invalid?
  end

  test 'create_self_and_transports' do
    record = Record.new(valid_params)
    assert record.hospital.hospital_transports

    assert ret = record.create_self_and_transports
    assert_equal 3, ret.size
    assert_equal hospitals(:hospital1), ret.first.hospital
    assert_equal transports(:transport1), ret.second.transport
    assert_equal transports(:transport2), ret.third.transport
  end

  test 'create_self_and_transports without hospital_transports' do
    record = Record.new(valid_params.merge(division: hospitals(:hospital2)))
    assert record.hospital.hospital_transports.blank?

    assert ret = record.create_self_and_transports
    assert_equal 1, ret.size
    assert_equal hospitals(:hospital2), ret.first.hospital
  end

  test 'create_self_and_transports invalid_record' do
    record = Record.new(valid_params.merge(date: nil))
    assert record.invalid?

    assert_no_difference -> {Record.count} do
      assert_not record.create_self_and_transports
    end
  end

  test 'return the total cost for each person and division for a year' do
    Record.delete_all

    d1 = hospitals(:hospital1)
    p1 = people(:user1)
    Record.create(division_id: d1.id, person_id: p1.id, date: Date.new(2020, 1, 1), cost: 100)
    Record.create(division_id: d1.id, person_id: p1.id, date: Date.new(2020, 6, 15), cost: 200)
    Record.create(division_id: d1.id, person_id: p1.id, date: Date.new(2020, 12, 31), cost: 300)

    d2 = drugstores(:drugstore1)
    p2 = people(:user2)
    Record.create(division_id: d2.id, person_id: p2.id, date: Date.new(2020, 1, 1), cost: 400)
    Record.create(division_id: d2.id, person_id: p2.id, date: Date.new(2020, 6, 15), cost: 500)

    d3 = transports(:transport1)
    p3 = people(:user3)
    Record.create(division_id: d3.id, person_id: p3.id, date: Date.new(2020, 1, 1), cost: 700)

    statistics = Record.annual_statistics(2020)
    assert_equal d1, statistics[0].division
    assert_equal p1, statistics[0].person
    assert_equal 600, statistics[0].sum_cost

    assert_equal d2, statistics[1].division
    assert_equal p2, statistics[1].person
    assert_equal 900, statistics[1].sum_cost

    assert_equal d3, statistics[2].division
    assert_equal p3, statistics[2].person
    assert_equal 700, statistics[2].sum_cost
  end

  test 'annual_statistics total cost by year' do
    Record.delete_all
    Record.create(valid_params.merge(date: Date.new(2017, 1, 1), cost: 100))
    Record.create(valid_params.merge(date: Date.new(2017, 12, 31), cost: 100))

    Record.create(valid_params.merge(date: Date.new(2018, 1, 1), cost: 200))
    Record.create(valid_params.merge(date: Date.new(2018, 12, 31), cost: 200))

    Record.create(valid_params.merge(date: Date.new(2019, 1, 1), cost: 300))
    Record.create(valid_params.merge(date: Date.new(2019, 12, 31), cost: 300))

    [2017, '2017'].each do |year|
      statistics = Record.annual_statistics(year)
      assert_equal 200, statistics[0].sum_cost
    end

    [2018, '2018'].each do |year|
      statistics = Record.annual_statistics(year)
      assert_equal 400, statistics[0].sum_cost
    end

    [2019, '2019'].each do |year|
      statistics = Record.annual_statistics(year)
      assert_equal 600, statistics[0].sum_cost
    end
  end

  test "returns the current year's statistics if year is not passed" do
    Record.delete_all
    Record.create(valid_params.merge(date: Date.new(2019, 1, 1), cost: 200))
    Record.create(valid_params.merge(date: Date.new(2019, 12, 31), cost: 200))
    Record.create(valid_params.merge(date: Date.new(2020, 1, 1), cost: 300))
    Record.create(valid_params.merge(date: Date.new(2020, 12, 31), cost: 300))

    Time.stub(:current, Time.new(2020, 4, 1).in_time_zone) do
      statistics = Record.annual_statistics(nil)
      assert_equal 600, statistics[0].sum_cost
    end
  end

  def valid_params
    hospital1 = hospitals(:hospital1)
    person1 = people(:user1)
    {date: Time.zone.today, cost: 100,
     division_id: hospital1.id, person_id: person1.id}
  end
end
