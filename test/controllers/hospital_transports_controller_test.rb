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
      post hospital_transports_url, params: {hospital_transport: {}}
    end

    assert_redirected_to hospital_transport_url(HospitalTransport.last)
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
    patch hospital_transport_url(@hospital_transport), params: {hospital_transport: {}}
    assert_redirected_to hospital_transport_url(@hospital_transport)
  end

  test 'should destroy hospital_transport' do
    assert_difference('HospitalTransport.count', -1) do
      delete hospital_transport_url(@hospital_transport)
    end

    assert_redirected_to hospital_transports_url
  end
end
