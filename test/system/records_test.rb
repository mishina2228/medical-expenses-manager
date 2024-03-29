# frozen_string_literal: true

require 'application_system_test_case'

class RecordsTest < ApplicationSystemTestCase
  setup do
    @person = people(:user1)
    @drugstore = drugstores(:drugstore1)
    @record = records(:record1)
    100.times do
      new_record.save!
    end
  end

  test 'visit the index' do
    visit records_url
    text = I18n.t('helpers.title.list', models: Record.model_name.human.pluralize(I18n.locale))
    assert_selector 'h1', text: text
  end

  test 'get max number of records when visit the index with per = MAX_PER + 1' do
    visit records_url(per: Record::MAX_PER + 1)
    assert_selector('table tbody tr', count: Record::MAX_PER)
  end

  test 'get default number of records when visit the index with per = 0' do
    visit records_url(per: 0)
    assert_selector('table tbody tr', count: Record::DEFAULT_PER)
  end

  test 'get default number of records when visit the index with per = -1' do
    visit records_url(per: -1)
    assert_selector('table tbody tr', count: Record::DEFAULT_PER)
  end

  test 'create a record' do
    visit records_url
    click_on I18n.t('helpers.link.new'), match: :first

    fill_in Record.human_attribute_name(:date), with: Date.current.strftime('%Y-%m-%d')
    select @person.name, from: 'record_person_id'
    select Drugstore.model_name.human, from: 'record_division_type'
    select @drugstore.name, from: 'division-id-select'
    fill_in Record.human_attribute_name(:cost), with: 120
    click_on I18n.t('helpers.submit.create')

    assert_text I18n.t('helpers.notice.create')
    text = I18n.t('helpers.title.list', models: Record.model_name.human.pluralize(I18n.locale))
    assert_selector 'h1', text: text
    page.assert_current_path(records_path)
  end

  test 'create a record continuously' do
    visit records_url
    click_on I18n.t('helpers.link.new'), match: :first

    fill_in Record.human_attribute_name(:date), with: Date.current.strftime('%Y-%m-%d')
    select @person.name, from: 'record_person_id'
    select Drugstore.model_name.human, from: 'record_division_type'
    select @drugstore.name, from: 'division-id-select'
    fill_in Record.human_attribute_name(:cost), with: 120
    check I18n.t('helpers.label.continuously_create')
    click_on I18n.t('helpers.submit.create')

    assert_text I18n.t('helpers.notice.create')
    assert_text I18n.t('helpers.notice.continuously_create')
    text = I18n.t('helpers.title.new', model: Record.model_name.human.pluralize(I18n.locale))
    assert_selector 'h1', text: text
    page.assert_current_path(new_record_path, ignore_query: true)
  end

  test 'update a record' do
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

  test 'destroy a record' do
    visit records_url
    click_on @record.date.strftime('%Y/%m/%d'), match: :first
    page.accept_confirm(I18n.t('helpers.notice.delete_confirm')) do
      click_on I18n.t('helpers.link.delete')
    end

    assert_text I18n.t('helpers.notice.delete')
    page.assert_current_path(records_path)
  end
end
