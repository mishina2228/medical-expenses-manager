require 'test_helper'

class PeopleControllerTest < ActionDispatch::IntegrationTest
  setup do
    @person = people(:user1)
  end

  test 'should get index' do
    get people_url
    assert_response :success
  end

  test 'should get new' do
    get new_person_url
    assert_response :success
  end

  test 'should create a person' do
    Person.delete_all
    assert_difference -> {Person.count} do
      post people_url,
           params: {
             person: {
               name: @person.name,
               relationship: @person.relationship
             }
           }
    end

    assert_response :redirect
    assert_redirected_to people_url
  end

  test 'should not create a person unless parameters are valid' do
    @person.name = nil
    assert @person.invalid?

    assert_no_difference -> {Person.count} do
      post people_url,
           params: {
             person: {
               name: @person.name,
               relationship: @person.relationship
             }
           }
    end

    assert_response :unprocessable_entity
  end

  test 'should show a person' do
    get person_url(id: @person)
    assert_response :success
  end

  test 'should get edit' do
    get edit_person_url(id: @person)
    assert_response :success
  end

  test 'should update a person' do
    patch person_url(id: @person),
          params: {
            person: {
              name: @person.name,
              relationship: @person.relationship
            }
          }

    assert_response :redirect
    assert_redirected_to people_url
  end

  test 'should not update a person unless parameters are valid' do
    before_name = @person.name
    @person.name = nil
    assert @person.invalid?

    patch person_url(id: @person),
          params: {
            person: {
              name: @person.name,
              relationship: @person.relationship
            }
          }

    assert_response :unprocessable_entity
    assert_equal before_name, @person.reload.name
  end

  test 'should destroy a person' do
    assert_difference -> {Person.count}, -1 do
      delete person_url(id: @person)
    end

    assert_response :redirect
    assert_redirected_to people_url
  end
end
