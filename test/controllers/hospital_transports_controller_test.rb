require 'test_helper'

class HospitalTransportsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @hospital_transport = hospital_transports(:病院交通費1)
  end

  test 'should get index' do
    get hospital_transports_url
    assert_response :success
  end

  test 'should get new' do
    get new_hospital_transport_url
    assert_response :success
  end

  test 'should create hospital_transport' do
    assert_difference('HospitalTransport.count') do
      post hospital_transports_url,
           params: {
             hospital_transport: {
               hospital_id: @hospital_transport.hospital_id,
               transport_id: @hospital_transport.transport_id,
               transport_cost: @hospital_transport.transport_cost
             }
           }
    end

    assert_redirected_to hospital_transports_url
  end

  test 'should show hospital_transport' do
    get hospital_transport_url(@hospital_transport)
    assert_response :success
  end

  test 'should get edit' do
    get edit_hospital_transport_url(@hospital_transport)
    assert_response :success
  end

  test 'should update hospital_transport' do
    patch hospital_transport_url(@hospital_transport),
          params: {
            hospital_transport: {
              hospital_id: @hospital_transport.hospital_id,
              transport_id: @hospital_transport.transport_id,
              transport_cost: @hospital_transport.transport_cost
            }
          }
    assert_redirected_to hospital_transports_url
  end

  test 'should destroy hospital_transport' do
    assert_difference('HospitalTransport.count', -1) do
      delete hospital_transport_url(@hospital_transport)
    end

    assert_redirected_to hospital_transports_url
  end
end
