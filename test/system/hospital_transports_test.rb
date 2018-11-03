require 'application_system_test_case'

class HospitalTransportsTest < ApplicationSystemTestCase
  setup do
    @hospital = hospitals(:病院2)
    @transport = transports(:交通機関1)
    @hospital_transport = hospital_transports(:病院交通費1)
  end

  test 'visiting the index' do
    visit hospital_transports_url
    assert_selector 'h1', text: I18n.t('helpers.title.list', models: HospitalTransport.model_name.human.pluralize(I18n.locale))
  end

  test 'creating a Hospital transport' do
    visit hospital_transports_url
    click_on I18n.t('helpers.link.new')

    select @hospital.name, from: 'hospital_transport_hospital_id'
    select @transport.name, from: 'hospital_transport_transport_id'
    fill_in HospitalTransport.human_attribute_name(:transport_cost),
            with: 120
    click_on I18n.t('helpers.submit.create')

    assert_text I18n.t('helpers.notice.create')
    assert_selector 'h1', text: I18n.t('helpers.title.list', models: HospitalTransport.model_name.human.pluralize(I18n.locale))
  end

  test 'updating a Hospital transport' do
    visit hospital_transports_url
    click_on 'Edit', match: :first

    click_on 'Update Hospital transport'

    assert_text 'Hospital transport was successfully updated'
    click_on 'Back'
  end

  test 'destroying a Hospital transport' do
    visit hospital_transports_url
    page.accept_confirm do
      click_on 'Destroy', match: :first
    end

    assert_text 'Hospital transport was successfully destroyed'
  end
end
