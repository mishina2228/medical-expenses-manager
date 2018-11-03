require 'application_system_test_case'

class TransportTest < ApplicationSystemTestCase
  setup do
    @transport = transports(:交通機関1)
  end

  test 'visiting the index' do
    visit transports_url
    assert_selector 'h1', text: I18n.t('helpers.title.list', models: Transport.model_name.human.pluralize(I18n.locale))
  end

  test 'creating a Transport' do
    visit transports_url
    click_on I18n.t('helpers.link.new')

    fill_in Transport.human_attribute_name(:name), with: @transport.name + Time.current.usec.to_s
    click_on I18n.t('helpers.submit.create')

    assert_text I18n.t('helpers.notice.create')
    assert_selector 'h1', text: I18n.t('helpers.title.list', models: Transport.model_name.human.pluralize(I18n.locale))
  end

  test 'updating a Transport' do
    visit transports_url
    click_on I18n.t('helpers.link.edit'), match: :first

    fill_in 'Name', with: @transport.name
    click_on 'Update Transport'

    assert_text 'Transport was successfully updated'
    click_on 'Back'
  end

  test 'destroying a Transport' do
    visit transports_url
    page.accept_confirm do
      click_on 'Destroy', match: :first
    end

    assert_text 'Transport was successfully destroyed'
  end
end
