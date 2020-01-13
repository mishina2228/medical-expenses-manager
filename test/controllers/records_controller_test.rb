require 'test_helper'

class RecordsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @record = records(:record1)
  end

  test 'should get index' do
    get records_url
    assert_response :success
  end

  test 'should get new' do
    get new_record_url
    assert_response :success
  end

  test 'should create a record' do
    Record.delete_all
    assert_equal 2, @record.hospital.hospital_transports.size

    assert_difference -> {Record.count}, 3 do
      post records_url,
           params: {
             record: {
               cost: @record.cost,
               date: @record.date,
               person_id: @record.person_id,
               division_id: @record.division_id
             }
           }
    end

    assert_response :redirect
    assert_redirected_to records_url
  end

  test 'should create records continuously when continuous parameter is given' do
    Record.delete_all
    assert_equal 2, @record.hospital.hospital_transports.size
    record_params = {
      record: {
        cost: @record.cost,
        date: @record.date,
        person_id: @record.person_id,
        division_id: @record.division_id
      }
    }

    assert_difference -> {Record.count}, 3 do
      post records_url, params: record_params.merge(continuous: true)
    end

    assert_response :redirect
    assert_redirected_to new_record_url(record_params)
  end

  test 'should not create a record unless parameters are valid' do
    @record.date = nil
    assert @record.invalid?

    assert_no_difference -> {Record.count} do
      post records_url,
           params: {
             record: {
               cost: @record.cost,
               date: @record.date,
               person_id: @record.person_id,
               division_id: @record.division_id
             }
           }
    end

    assert_response :success
  end

  test 'should show a record' do
    get record_url(id: @record)
    assert_response :success
  end

  test 'should get edit' do
    get edit_record_url(id: @record)
    assert_response :success
  end

  test 'should update a record' do
    patch record_url(id: @record),
          params: {
            record: {
              cost: @record.cost
            }
          }

    assert_response :redirect
    assert_redirected_to records_url
  end

  test 'should not update a record unless parameters are valid' do
    before_cost = @record.cost
    @record.cost = nil
    assert @record.invalid?

    patch record_url(id: @record),
          params: {
            record: {
              cost: @record.cost
            }
          }

    assert_response :success
    assert_equal before_cost, @record.reload.cost
  end

  test 'should destroy a record' do
    assert_difference -> {Record.count}, -1 do
      delete record_url(id: @record)
    end

    assert_response :redirect
    assert_redirected_to records_url
  end

  test 'should get records that match the search conditions' do
    get search_records_url(search_record: {division_type: 'Hospital', to_date: Time.zone.today})
    assert_response :success

    get search_records_url # no params
    assert_response :success
  end
end
