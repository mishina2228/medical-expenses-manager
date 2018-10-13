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
    Transport.delete_all
    assert_difference('Transport.count') do
      post transports_url,
           params: {
             transport: {
               name: @transport.name
             }
           }
    end

    assert_redirected_to transports_url
  end

  test 'should show transports' do
    get transport_url(id: @transport)
    assert_response :success
  end

  test 'should get edit' do
    get edit_transport_url(id: @transport)
    assert_response :success
  end

  test 'should update transports' do
    patch transport_url(id: @transport),
          params: {
            transport: {
              name: @transport.name
            }
          }
    assert_redirected_to transports_url
  end

  test 'should destroy transports' do
    assert_difference('Transport.count', -1) do
      delete transport_url(id: @transport)
    end

    assert_redirected_to transports_url
  end
end
