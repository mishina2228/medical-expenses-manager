require 'application_system_test_case'

class PeopleTest < ApplicationSystemTestCase
  setup do
    @person = people(:user1)
  end

  test 'visit the index' do
    visit people_url
    text = I18n.t('helpers.title.list', models: Person.model_name.human.pluralize(I18n.locale))
    assert_selector 'h1', text: text
  end

  test 'create a person' do
    visit people_url
    click_on I18n.t('helpers.link.new')

    fill_in Person.human_attribute_name(:name), with: @person.name + Time.current.usec.to_s
    fill_in Person.human_attribute_name(:relationship), with: @person.relationship
    click_on I18n.t('helpers.submit.create')

    assert_text I18n.t('helpers.notice.create')
    text = I18n.t('helpers.title.list', models: Person.model_name.human.pluralize(I18n.locale))
    assert_selector 'h1', text: text
    page.assert_current_path(people_path)
  end

  test 'create a person with invalid parameters' do
    visit people_url
    click_on I18n.t('helpers.link.new')

    fill_in Person.human_attribute_name(:name), with: @person.name
    fill_in Person.human_attribute_name(:relationship), with: @person.relationship
    click_on I18n.t('helpers.submit.create')

    assert_text I18n.t('errors.messages.taken')
    page.assert_current_path(new_person_path)
  end

  test 'update a person' do
    visit people_url
    click_on @person.name, match: :first
    click_on I18n.t('helpers.link.edit')
    page.assert_current_path(edit_person_path(id: @person.id))

    after_name = @person.name + Time.current.usec.to_s
    after_relationship = @person.relationship + Time.current.usec.to_s
    fill_in Person.human_attribute_name(:name), with: after_name
    fill_in Person.human_attribute_name(:relationship), with: after_relationship
    click_on I18n.t('helpers.submit.update')

    assert_text I18n.t('helpers.notice.update')
    page.assert_current_path(people_path)
    assert_equal after_name, @person.reload.name
    assert_equal after_relationship, @person.reload.relationship
  end

  test 'update a person with invalid parameters' do
    visit people_url
    click_on @person.name, match: :first
    click_on I18n.t('helpers.link.edit')
    page.assert_current_path(edit_person_path(id: @person.id))

    fill_in Person.human_attribute_name(:name), with: people(:user2).name
    fill_in Person.human_attribute_name(:relationship), with: people(:user2).relationship
    click_on I18n.t('helpers.submit.update')

    assert_text I18n.t('errors.messages.taken')
    page.assert_current_path(edit_person_path(id: @person.id))
  end

  test 'destroy a person' do
    visit people_url
    click_on @person.name, match: :first
    page.accept_confirm(I18n.t('helpers.notice.delete_confirm')) do
      click_on I18n.t('helpers.link.delete')
    end

    assert_text I18n.t('helpers.notice.delete')
    page.assert_current_path(people_path)
  end
end
