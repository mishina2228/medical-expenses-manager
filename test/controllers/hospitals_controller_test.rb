require 'test_helper'

class HospitalsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @hospital = hospitals(:病院1)
  end

  test 'should get index' do
    get hospitals_url
    assert_response :success
  end

  test 'should get new' do
    get new_hospital_url
    assert_response :success
  end

  test 'should create hospital' do
    Hospital.delete_all
    assert_difference('Hospital.count') do
      post hospitals_url,
           params: {
             hospital: {
               name: @hospital.name
             }
           }
    end

    assert_redirected_to hospitals_url
  end

  test 'should show hospital' do
    get hospital_url(id: @hospital)
    assert_response :success
  end

  test 'should get edit' do
    get edit_hospital_url(id: @hospital)
    assert_response :success
  end

  test 'should update hospital' do
    patch hospital_url(id: @hospital),
          params: {
            hospital: {
              name: @hospital.name
            }
          }
    assert_redirected_to hospitals_url
  end

  test 'should destroy hospital' do
    assert_difference('Hospital.count', -1) do
      delete hospital_url(id: @hospital)
    end

    assert_redirected_to hospitals_url
  end
end
