# frozen_string_literal: true

require 'application_system_test_case'

class HospitalsTest < ApplicationSystemTestCase
  setup do
    @hospital = hospitals(:hospital1)
  end

  test 'visit the index' do
    visit hospitals_url
    text = I18n.t('helpers.title.list', models: Hospital.model_name.human.pluralize(I18n.locale))
    assert_selector 'h1', text: text
  end

  test 'create a hospital' do
    visit hospitals_url
    click_on I18n.t('helpers.link.new')

    fill_in Hospital.human_attribute_name(:name), with: @hospital.name + Time.current.usec.to_s
    click_on I18n.t('helpers.submit.create')

    assert_text I18n.t('helpers.notice.create')
    text = I18n.t('helpers.title.list', models: Hospital.model_name.human.pluralize(I18n.locale))
    assert_selector 'h1', text: text
    page.assert_current_path(hospitals_path)
  end

  test 'create a hospital with transports' do
    visit hospitals_url
    click_on I18n.t('helpers.link.new')

    fill_in Hospital.human_attribute_name(:name), with: @hospital.name + Time.current.usec.to_s
    find('a.add_fields').click
    find("select[name$='[transport_id]']").select(transports(:transport1).name)
    find("input[name$='[transport_cost]']").set(42)
    click_on I18n.t('helpers.submit.create')

    assert_text I18n.t('helpers.notice.create')
    text = I18n.t('helpers.title.list', models: Hospital.model_name.human.pluralize(I18n.locale))
    assert_selector 'h1', text: text
    page.assert_current_path(hospitals_path)
  end

  test 'create a hospital with invalid parameters' do
    visit hospitals_url
    click_on I18n.t('helpers.link.new')

    fill_in Hospital.human_attribute_name(:name), with: @hospital.name
    click_on I18n.t('helpers.submit.create')

    assert_text I18n.t('errors.messages.taken')
    page.assert_current_path(new_hospital_path)
  end

  test 'update a hospital' do
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

  test 'update a hospital with transports' do
    visit hospitals_url
    click_on @hospital.name, match: :first
    click_on I18n.t('helpers.link.edit')
    page.assert_current_path(edit_hospital_path(id: @hospital.id))

    all('a.add_fields').last.click
    all("select[name$='[transport_id]']").last.select(transports(:plane).name)
    all("input[name$='[transport_cost]']").last.set(42)
    click_on I18n.t('helpers.submit.update')

    assert_text I18n.t('helpers.notice.update')
    page.assert_current_path(hospitals_path)
  end

  test 'update a hospital with invalid parameters' do
    visit hospitals_url
    click_on @hospital.name, match: :first
    click_on I18n.t('helpers.link.edit')
    page.assert_current_path(edit_hospital_path(id: @hospital.id))

    fill_in Hospital.human_attribute_name(:name), with: hospitals(:hospital2).name
    click_on I18n.t('helpers.submit.update')

    assert_text I18n.t('errors.messages.taken')
    page.assert_current_path(edit_hospital_path(id: @hospital.id))
  end

  test 'destroy a hospital' do
    visit hospitals_url
    click_on @hospital.name, match: :first
    page.accept_confirm(I18n.t('helpers.notice.delete_confirm')) do
      click_on I18n.t('helpers.link.delete')
    end

    assert_text I18n.t('helpers.notice.delete')
    page.assert_current_path(hospitals_path)
  end
end
