require 'test_helper'

class TransportsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @transport = transports(:交通機関1)
  end

  test 'should get index' do
    get transports_url
    assert_response :success
  end

  test 'should get new' do
    get new_transport_url
    assert_response :success
  end

  test 'should create transports' do
    assert_difference('Transport.count') do
      post transports_url, params: {transports: {name: @transport.name}}
    end

    assert_redirected_to transport_url(Transport.last)
  end

  test 'should show transports' do
    get transport_url(@transport)
    assert_response :success
  end

  test 'should get edit' do
    get edit_transport_url(@transport)
    assert_response :success
  end

  test 'should update transports' do
    patch transport_url(@transport), params: {transports: {name: @transport.name}}
    assert_redirected_to transport_url(@transport)
  end

  test 'should destroy transports' do
    assert_difference('Transport.count', -1) do
      delete transport_url(@transport)
    end

    assert_redirected_to transports_url
  end
end
