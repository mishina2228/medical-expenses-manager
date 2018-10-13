require 'test_helper'

class DrugstoresControllerTest < ActionDispatch::IntegrationTest
  setup do
    @drugstore = drugstores(:薬局1)
  end

  test 'should get index' do
    get drugstores_url
    assert_response :success
  end

  test 'should get new' do
    get new_drugstore_url
    assert_response :success
  end

  test 'should create drugstore' do
    Drugstore.delete_all
    assert_difference('Drugstore.count') do
      post drugstores_url,
           params: {
             drugstore: {
               name: @drugstore.name
             }
           }
    end

    assert_redirected_to drugstores_url
  end

  test 'should show drugstore' do
    get drugstore_url(id: @drugstore)
    assert_response :success
  end

  test 'should get edit' do
    get edit_drugstore_url(id: @drugstore)
    assert_response :success
  end

  test 'should update drugstore' do
    patch drugstore_url(id: @drugstore),
          params: {
            drugstore: {
              name: @drugstore.name
            }
          }
    assert_redirected_to drugstores_url
  end

  test 'should destroy drugstore' do
    assert_difference('Drugstore.count', -1) do
      delete drugstore_url(id: @drugstore)
    end

    assert_redirected_to drugstores_url
  end
end
