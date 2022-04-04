# frozen_string_literal: true

require 'test_helper'

class DivisionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @drugstore = drugstores(:drugstore1)
  end

  test 'should get all hospital names' do
    get divisions_url klass: 'Hospital'

    assert_response :success
    hospitals = JSON.parse(@response.body)
    assert_equal Hospital.count, hospitals.size
    records = Hospital.all.select(:id, :name)
    records.each do |r|
      assert_includes hospitals, {'id' => r.id, 'name' => r.name}
    end
  end

  test 'should get all drugstore names' do
    get divisions_url klass: 'Drugstore'

    assert_response :success
    drugstores = JSON.parse(@response.body)
    assert_equal Drugstore.count, drugstores.size
    records = Drugstore.all.select(:id, :name)
    records.each do |r|
      assert_includes drugstores, {'id' => r.id, 'name' => r.name}
    end
  end

  test 'should get all transport names' do
    get divisions_url klass: 'Transport'

    assert_response :success
    transports = JSON.parse(@response.body)
    assert_equal Transport.count, transports.size
    records = Transport.all.select(:id, :name)
    records.each do |r|
      assert_includes transports, {'id' => r.id, 'name' => r.name}
    end
  end
end
