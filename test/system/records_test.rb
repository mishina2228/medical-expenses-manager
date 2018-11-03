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

  test 'updating a Record' do
    visit records_url
    click_on 'Edit', match: :first

    fill_in 'Cost', with: @record.cost
    click_on 'Update Record'

    assert_text 'Record was successfully updated'
    click_on 'Back'
  end

  test 'destroying a Record' do
    visit records_url
    page.accept_confirm do
      click_on 'Destroy', match: :first
    end

    assert_text 'Record was successfully destroyed'
  end
end
