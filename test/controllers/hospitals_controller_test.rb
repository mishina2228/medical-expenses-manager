require 'test_helper'

class HospitalsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @hospital = hospitals(:hospital1)
  end

  test 'should get index' do
    get hospitals_url
    assert_response :success
  end

  test 'should get new' do
    get new_hospital_url
    assert_response :success
  end

  test 'should create a hospital with hospital_transports' do
    Hospital.delete_all
    assert_difference -> {Hospital.count} do
      assert_difference -> {HospitalTransport.count}, 2 do
        post hospitals_url, params: hospitals_params
      end
    end

    assert_response :redirect
    assert_redirected_to hospitals_url
  end

  test 'should not create a hospital unless parameters are valid' do
    assert_no_difference -> {Hospital.count} do
      post hospitals_url, params: hospitals_params.merge(name: nil)
    end

    assert_response :success
  end

  test 'should show a hospital' do
    get hospital_url(id: @hospital)
    assert_response :success
  end

  test 'should get edit' do
    get edit_hospital_url(id: @hospital)
    assert_response :success
  end

  test 'should update a hospital' do
    name = @hospital.name + 'test1'
    patch hospital_url(id: @hospital),
          params: {
            hospital: {
              name: name
            }
          }

    assert_response :redirect
    assert_redirected_to hospitals_url
    assert_equal name, @hospital.reload.name
  end

  test 'should not update a hospital unless parameters are valid' do
    before_name = @hospital.name
    @hospital.name = nil
    assert @hospital.invalid?

    patch hospital_url(id: @hospital),
          params: {
            hospital: {
              name: @hospital.name
            }
          }

    assert_response :success
    assert_equal before_name, @hospital.reload.name
  end

  test 'should update hospital_transports' do
    assert_equal 2, @hospital.hospital_transports.count
    ht1 = @hospital.hospital_transports.first
    ht2 = @hospital.hospital_transports.second
    assert_equal 200, ht2.transport_cost
    params = {
      hospital: {
        name: @hospital.name,
        hospital_transports_attributes: {
          '0' => {
            id: ht1.id, transport_id: transports(:transport1).id, transport_cost: 100,
            _destroy: true
          },
          '1' => {id: ht2.id, transport_id: transports(:train).id, transport_cost: 4000},
          '2' => {transport_id: transports(:plane).id, transport_cost: 10000}
        }
      }
    }

    patch hospital_url(id: @hospital), params: params

    assert_response :redirect
    assert_redirected_to hospitals_url
    assert_equal 2, @hospital.hospital_transports.count
    assert_equal 4000, ht2.reload.transport_cost
  end

  test 'should destroy a hospital with hospital_transports' do
    assert_equal 2, @hospital.hospital_transports.size
    assert_difference -> {Hospital.count}, -1 do
      assert_difference -> {HospitalTransport.count}, -2 do
        delete hospital_url(id: @hospital)
      end
    end

    assert_response :redirect
    assert_redirected_to hospitals_url
  end

  def hospitals_params
    {
      hospital: {
        name: :hospital1,
        hospital_transports_attributes: {
          '0' => {transport_id: transports(:transport1).id, transport_cost: 100},
          '1' => {transport_id: transports(:transport2).id, transport_cost: 200}
        }
      }
    }
  end
end
