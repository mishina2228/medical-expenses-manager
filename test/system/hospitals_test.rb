require 'application_system_test_case'

class HospitalsTest < ApplicationSystemTestCase
  setup do
    @hospital = hospitals(:hospital1)
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
    click_on @hospital.name, match: :first
    click_on I18n.t('helpers.link.edit')
    page.assert_current_path(edit_hospital_path(id: @hospital.id))

    after_name = @hospital.name + Time.current.usec.to_s
    fill_in Hospital.human_attribute_name(:name), with: after_name
    click_on I18n.t('helpers.submit.update')

    assert_text I18n.t('helpers.notice.update')
    page.assert_current_path(hospitals_path)
    assert_equal after_name, @hospital.reload.name
  end

  test 'destroying a Hospital' do
    visit hospitals_url
    click_on @hospital.name, match: :first
    page.accept_confirm do
      click_on I18n.t('helpers.link.delete')
    end

    assert_text I18n.t('helpers.notice.delete')
  end
end
