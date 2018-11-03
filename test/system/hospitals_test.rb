require 'application_system_test_case'

class HospitalsTest < ApplicationSystemTestCase
  setup do
    @hospital = hospitals(:病院1)
  end

  test 'visiting the index' do
    visit hospitals_url
    assert_selector 'h1', text: I18n.t('helpers.title.list', models: Hospital.model_name.human.pluralize(I18n.locale))
  end

  test 'creating a Hospital' do
    visit hospitals_url
    click_on I18n.t('helpers.link.new')

    fill_in Hospital.human_attribute_name(:name), with: @hospital.name + Time.current.usec.to_s
    click_on I18n.t('helpers.submit.create')

    assert_text I18n.t('helpers.notice.create')
    assert_selector 'h1', text: I18n.t('helpers.title.list', models: Hospital.model_name.human.pluralize(I18n.locale))
  end

  test 'updating a Hospital' do
    visit hospitals_url
    click_on 'Edit', match: :first

    fill_in 'Expense', with: @hospital.expense
    fill_in 'Name', with: @hospital.name
    fill_in 'Transport', with: @hospital.transport
    click_on 'Update Hospital'

    assert_text 'Hospital was successfully updated'
    click_on 'Back'
  end

  test 'destroying a Hospital' do
    visit hospitals_url
    page.accept_confirm do
      click_on 'Destroy', match: :first
    end

    assert_text 'Hospital was successfully destroyed'
  end
end
