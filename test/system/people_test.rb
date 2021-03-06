require 'application_system_test_case'

class PeopleTest < ApplicationSystemTestCase
  setup do
    @person = people(:user1)
  end

  test 'visiting the index' do
    visit people_url
    text = I18n.t('helpers.title.list', models: Person.model_name.human.pluralize(I18n.locale))
    assert_selector 'h1', text: text
  end

  test 'creating a Person' do
    visit people_url
    click_on I18n.t('helpers.link.new')

    fill_in Person.human_attribute_name(:name), with: @person.name + Time.current.usec.to_s
    fill_in Person.human_attribute_name(:relationship), with: @person.relationship
    click_on I18n.t('helpers.submit.create')

    assert_text I18n.t('helpers.notice.create')
    text = I18n.t('helpers.title.list', models: Person.model_name.human.pluralize(I18n.locale))
    assert_selector 'h1', text: text
  end

  test 'updating a Person' do
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

  test 'destroying a Person' do
    visit people_url
    click_on @person.name, match: :first
    page.accept_confirm do
      click_on I18n.t('helpers.link.delete')
    end

    assert_text I18n.t('helpers.notice.delete')
  end
end
