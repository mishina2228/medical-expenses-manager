require 'application_system_test_case'

class RecordsTest < ApplicationSystemTestCase
  setup do
    @person = people(:ユーザー1)
    @drugstore = drugstores(:薬局1)
    @record = records(:記録1)
  end

  test 'visiting the index' do
    visit records_url
    assert_selector 'h1', text: I18n.t('helpers.title.list', models: Record.model_name.human.pluralize(I18n.locale))
  end

  test 'creating a Record' do
    visit records_url
    click_on I18n.t('helpers.link.new'), match: :first

    fill_in Record.human_attribute_name(:date), with: Date.today.strftime('%Y-%m-%d')
    select @person.name, from: 'record_person_id'
    select Drugstore.model_name.human, from: 'record_division_type'
    select @drugstore.name, from: 'record_division_id'
    fill_in Record.human_attribute_name(:cost), with: 120
    click_on I18n.t('helpers.submit.create')

    assert_text I18n.t('helpers.notice.create')
    assert_selector 'h1', text: I18n.t('helpers.title.list', models: Record.model_name.human.pluralize(I18n.locale))
  end

  test 'creating a Record continuously' do
    visit records_url
    click_on I18n.t('helpers.link.new'), match: :first

    fill_in Record.human_attribute_name(:date), with: Date.today.strftime('%Y-%m-%d')
    select @person.name, from: 'record_person_id'
    select Drugstore.model_name.human, from: 'record_division_type'
    select @drugstore.name, from: 'record_division_id'
    fill_in Record.human_attribute_name(:cost), with: 120
    check I18n.t('helpers.label.continuously_create')
    click_on I18n.t('helpers.submit.create')

    assert_text I18n.t('helpers.notice.create')
    assert_text I18n.t('helpers.notice.continuously_create')
    assert_selector 'h1', text: I18n.t('helpers.title.new', model: Record.model_name.human.pluralize(I18n.locale))
  end

  test 'updating a Record' do
    visit records_url
    click_on @record.date.strftime('%Y/%m/%d'), match: :first
    click_on I18n.t('helpers.link.edit')
    page.assert_current_path(edit_record_path(id: @record.id))

    after_cost = @record.cost + 123
    fill_in Record.human_attribute_name(:cost), with: after_cost
    click_on I18n.t('helpers.submit.update')

    assert_text I18n.t('helpers.notice.update')
    page.assert_current_path(records_path)
    assert_equal after_cost, @record.reload.cost
  end

  test 'destroying a Record' do
    visit records_url
    click_on @record.date.strftime('%Y/%m/%d'), match: :first
    page.accept_confirm do
      click_on I18n.t('helpers.link.delete')
    end

    assert_text I18n.t('helpers.notice.delete')
  end
end
