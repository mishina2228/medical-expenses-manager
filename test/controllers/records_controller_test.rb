require 'test_helper'

class RecordsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @record = records(:記録1)
  end

  test 'should get index' do
    get records_url
    assert_response :success
  end

  test 'should get new' do
    get new_record_url
    assert_response :success
  end

  test 'should create record' do
    Record.delete_all
    assert_equal 2, @record.hospital.hospital_transports.size

    assert_difference('Record.count', 3) do
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

    assert_redirected_to records_url
  end

  test 'should show record' do
    get record_url(id: @record)
    assert_response :success
  end

  test 'should get edit' do
    get edit_record_url(id: @record)
    assert_response :success
  end

  test 'should update record' do
    patch record_url(id: @record),
          params: {
            record: {
              cost: @record.cost
            }
          }
    assert_redirected_to records_url
  end

  test 'should destroy record' do
    assert_difference('Record.count', -1) do
      delete record_url(id: @record)
    end

    assert_redirected_to records_url
  end
end
