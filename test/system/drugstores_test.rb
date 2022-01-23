require 'application_system_test_case'

class DrugstoresTest < ApplicationSystemTestCase
  setup do
    @drugstore = drugstores(:drugstore1)
  end

  test 'visit the index' do
    visit drugstores_url
    text = I18n.t('helpers.title.list', models: Drugstore.model_name.human.pluralize(I18n.locale))
    assert_selector 'h1', text: text
  end

  test 'create a drugstore' do
    visit drugstores_url
    click_on I18n.t('helpers.link.new')

    fill_in Drugstore.human_attribute_name(:name), with: @drugstore.name + Time.current.usec.to_s
    click_on I18n.t('helpers.submit.create')

    assert_text I18n.t('helpers.notice.create')
    text = I18n.t('helpers.title.list', models: Drugstore.model_name.human.pluralize(I18n.locale))
    assert_selector 'h1', text: text
    page.assert_current_path(drugstores_path)
  end

  test 'create a drugstore with invalid parameters' do
    visit drugstores_url
    click_on I18n.t('helpers.link.new')

    fill_in Drugstore.human_attribute_name(:name), with: @drugstore.name
    click_on I18n.t('helpers.submit.create')

    assert_text I18n.t('errors.messages.taken')
    page.assert_current_path(new_drugstore_path)
  end

  test 'update a drugstore' do
    visit drugstores_url
    click_on @drugstore.name, match: :first
    click_on I18n.t('helpers.link.edit')
    page.assert_current_path(edit_drugstore_path(id: @drugstore.id))

    after_name = @drugstore.name + Time.current.usec.to_s
    fill_in Drugstore.human_attribute_name(:name), with: after_name
    click_on I18n.t('helpers.submit.update')

    assert_text I18n.t('helpers.notice.update')
    page.assert_current_path(drugstores_path)
    assert_equal after_name, @drugstore.reload.name
  end

  test 'update a drugstore with invalid parameters' do
    visit drugstores_url
    click_on @drugstore.name, match: :first
    click_on I18n.t('helpers.link.edit')
    page.assert_current_path(edit_drugstore_path(id: @drugstore.id))

    fill_in Drugstore.human_attribute_name(:name), with: drugstores(:drugstore2).name
    click_on I18n.t('helpers.submit.update')

    assert_text I18n.t('errors.messages.taken')
    page.assert_current_path(edit_drugstore_path(id: @drugstore.id))
  end

  test 'destroy a drugstore' do
    visit drugstores_url
    click_on @drugstore.name, match: :first
    page.accept_confirm do
      click_on I18n.t('helpers.link.delete')
    end

    assert_text I18n.t('helpers.notice.delete')
    page.assert_current_path(drugstores_path)
  end
end
