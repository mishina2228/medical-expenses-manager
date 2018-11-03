require 'application_system_test_case'

class PeopleTest < ApplicationSystemTestCase
  setup do
    @person = people(:ユーザー1)
  end

  test 'visiting the index' do
    visit people_url
    assert_selector 'h1', text: I18n.t('helpers.title.list', models: Person.model_name.human.pluralize(I18n.locale))
  end

  test 'creating a Person' do
    visit people_url
    click_on I18n.t('helpers.link.new')

    fill_in Person.human_attribute_name(:name), with: @person.name + Time.current.usec.to_s
    fill_in Person.human_attribute_name(:relationship), with: @person.relationship
    click_on I18n.t('helpers.submit.create')

    assert_text I18n.t('helpers.notice.create')
    assert_selector 'h1', text: I18n.t('helpers.title.list', models: Person.model_name.human.pluralize(I18n.locale))
  end

  test 'updating a Person' do
    visit people_url
    click_on 'Edit', match: :first

    fill_in 'Name', with: @person.name
    fill_in 'Relationship', with: @person.relationship
    click_on 'Update Person'

    assert_text 'Person was successfully updated'
    click_on 'Back'
  end

  test 'destroying a Person' do
    visit people_url
    page.accept_confirm do
      click_on 'Destroy', match: :first
    end

    assert_text 'Person was successfully destroyed'
  end
end
