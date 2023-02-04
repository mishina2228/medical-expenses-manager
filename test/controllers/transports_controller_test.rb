# frozen_string_literal: true

require 'test_helper'

class TransportsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @transport = transports(:transport1)
  end

  test 'should get index' do
    get transports_url
    assert_response :success
  end

  test 'should get new' do
    get new_transport_url
    assert_response :success
  end

  test 'should create a transport' do
    Transport.delete_all
    assert_difference -> {Transport.count} do
      post transports_url,
           params: {
             transport: {
               name: @transport.name
             }
           }
    end

    assert_response :redirect
    assert_redirected_to transports_url
  end

  test 'should not create a transport unless parameters are valid' do
    @transport.name = nil
    assert @transport.invalid?

    assert_no_difference -> {Transport.count} do
      post transports_url,
           params: {
             transport: {
               name: @transport.name
             }
           }
    end

    assert_response :unprocessable_entity
  end

  test 'should show a transport' do
    get transport_url(id: @transport)
    assert_response :success
  end

  test 'should get edit' do
    get edit_transport_url(id: @transport)
    assert_response :success
  end

  test 'should update a transport' do
    patch transport_url(id: @transport),
          params: {
            transport: {
              name: @transport.name
            }
          }

    assert_response :redirect
    assert_redirected_to transports_url
  end

  test 'should not update a transport unless parameters are valid' do
    before_name = @transport.name
    @transport.name = nil
    assert @transport.invalid?

    patch transport_url(id: @transport),
          params: {
            transport: {
              name: @transport.name
            }
          }

    assert_response :unprocessable_entity
    assert_equal before_name, @transport.reload.name
  end

  test 'should destroy a transport' do
    assert_difference -> {Transport.count}, -1 do
      delete transport_url(id: @transport)
    end

    assert_response :redirect
    assert_response :see_other
    assert_redirected_to transports_url
  end
end
