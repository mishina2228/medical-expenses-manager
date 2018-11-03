require 'application_system_test_case'

class DrugstoresTest < ApplicationSystemTestCase
  setup do
    @drugstore = drugstores(:薬局1)
  end

  test 'visiting the index' do
    visit drugstores_url
    assert_selector 'h1', text: I18n.t('helpers.title.list', models: Drugstore.model_name.human.pluralize(I18n.locale))
  end

  test 'creating a Drugstore' do
    visit drugstores_url
    click_on I18n.t('helpers.link.new')

    fill_in Drugstore.human_attribute_name(:name), with: @drugstore.name + Time.current.usec.to_s
    click_on I18n.t('helpers.submit.create')

    assert_text I18n.t('helpers.notice.create')
    assert_selector 'h1', text: I18n.t('helpers.title.list', models: Drugstore.model_name.human.pluralize(I18n.locale))
  end

  test 'updating a Drugstore' do
    visit drugstores_url
    click_on 'Edit', match: :first

    fill_in 'Name', with: @drugstore.name
    click_on 'Update Drugstore'

    assert_text 'Drugstore was successfully updated'
    click_on 'Back'
  end

  test 'destroying a Drugstore' do
    visit drugstores_url
    page.accept_confirm do
      click_on 'Destroy', match: :first
    end

    assert_text 'Drugstore was successfully destroyed'
  end
end
