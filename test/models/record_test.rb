require 'test_helper'

class RecordTest < ActiveSupport::TestCase
  def test_validation
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

  def test_create_self_and_transports_正常系
    record = Record.new(valid_params)
    assert record.hospital.hospital_transports

    assert ret = record.create_self_and_transports
    assert_equal 3, ret.size
    assert_equal hospitals(:病院1), ret.first.hospital
    assert_equal transports(:交通機関1), ret.second.transport
    assert_equal transports(:交通機関2), ret.third.transport
  end

  def test_create_self_and_transports_正常系_交通費なし
    record = Record.new(valid_params.merge(division: hospitals(:病院2)))
    assert record.hospital.hospital_transports.blank?

    assert ret = record.create_self_and_transports
    assert_equal 1, ret.size
    assert_equal hospitals(:病院2), ret.first.hospital
  end

  def test_create_self_and_transports_異常系_invalid_record
    record = Record.new(valid_params.merge(date: nil))
    assert record.invalid?

    assert_no_difference -> {Record.count} do
      assert_not record.create_self_and_transports
    end
  end

  def test_annual_statistics_年ごとの合計
    Record.delete_all
    Record.create(valid_params.merge(date: Date.new(2017, 1, 1), cost: 100))
    Record.create(valid_params.merge(date: Date.new(2017, 12, 31), cost: 100))

    Record.create(valid_params.merge(date: Date.new(2018, 1, 1), cost: 200))
    Record.create(valid_params.merge(date: Date.new(2018, 12, 31), cost: 200))

    Record.create(valid_params.merge(date: Date.new(2019, 1, 1), cost: 300))
    Record.create(valid_params.merge(date: Date.new(2019, 12, 31), cost: 300))

    ret = Record.annual_statistics(2017)
    ret.each do |r|
      assert_equal 200, r.sum_cost
    end

    ret = Record.annual_statistics(2018)
    ret.each do |r|
      assert_equal 400, r.sum_cost
    end

    ret = Record.annual_statistics(2019)
    ret.each do |r|
      assert_equal 600, r.sum_cost
    end
  end

  def valid_params
    hospital1 = hospitals(:病院1)
    person1 = people(:ユーザー1)
    {date: Time.zone.today, cost: 100,
     division_id: hospital1.id, person_id: person1.id}
  end
end
