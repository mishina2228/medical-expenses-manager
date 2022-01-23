require 'test_helper'

class DrugstoresControllerTest < ActionDispatch::IntegrationTest
  setup do
    @drugstore = drugstores(:drugstore1)
  end

  test 'should get index' do
    get drugstores_url
    assert_response :success
  end

  test 'should get new' do
    get new_drugstore_url
    assert_response :success
  end

  test 'should create a drugstore' do
    Drugstore.delete_all
    assert_difference -> {Drugstore.count} do
      post drugstores_url,
           params: {
             drugstore: {
               name: @drugstore.name
             }
           }
    end

    assert_response :redirect
    assert_redirected_to drugstores_url
  end

  test 'should not create a drugstore unless parameters are valid' do
    @drugstore.name = nil
    assert @drugstore.invalid?

    assert_no_difference -> {Drugstore.count} do
      post drugstores_url,
           params: {
             drugstore: {
               name: @drugstore.name
             }
           }
    end

    assert_response :unprocessable_entity
  end

  test 'should show a drugstore' do
    get drugstore_url(id: @drugstore)
    assert_response :success
  end

  test 'should get edit' do
    get edit_drugstore_url(id: @drugstore)
    assert_response :success
  end

  test 'should update a drugstore' do
    patch drugstore_url(id: @drugstore),
          params: {
            drugstore: {
              name: @drugstore.name
            }
          }

    assert_response :redirect
    assert_redirected_to drugstores_url
  end

  test 'should not update a drugstore unless parameters are valid' do
    before_name = @drugstore.name
    @drugstore.name = nil
    assert @drugstore.invalid?

    patch drugstore_url(id: @drugstore),
          params: {
            drugstore: {
              name: @drugstore.name
            }
          }

    assert_response :unprocessable_entity
    assert_equal before_name, @drugstore.reload.name
  end

  test 'should destroy a drugstore' do
    assert_difference -> {Drugstore.count}, -1 do
      delete drugstore_url(id: @drugstore)
    end

    assert_response :redirect
    assert_redirected_to drugstores_url
  end
end
