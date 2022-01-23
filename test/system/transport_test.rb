require 'application_system_test_case'

class TransportTest < ApplicationSystemTestCase
  setup do
    @transport = transports(:transport1)
  end

  test 'visit the index' do
    visit transports_url
    text = I18n.t('helpers.title.list', models: Transport.model_name.human.pluralize(I18n.locale))
    assert_selector 'h1', text: text
  end

  test 'create a transport' do
    visit transports_url
    click_on I18n.t('helpers.link.new')

    fill_in Transport.human_attribute_name(:name), with: @transport.name + Time.current.usec.to_s
    click_on I18n.t('helpers.submit.create')

    assert_text I18n.t('helpers.notice.create')
    text = I18n.t('helpers.title.list', models: Transport.model_name.human.pluralize(I18n.locale))
    assert_selector 'h1', text: text
    page.assert_current_path(transports_path)
  end

  test 'update a transport' do
    visit transports_url
    click_on @transport.name, match: :first
    click_on I18n.t('helpers.link.edit')
    page.assert_current_path(edit_transport_path(id: @transport.id))

    after_name = @transport.name + Time.current.usec.to_s
    fill_in Transport.human_attribute_name(:name), with: after_name
    click_on I18n.t('helpers.submit.update')

    assert_text I18n.t('helpers.notice.update')
    page.assert_current_path(transports_path)
    assert_equal after_name, @transport.reload.name
  end

  test 'destroy a transport' do
    visit transports_url
    click_on @transport.name, match: :first
    page.accept_confirm do
      click_on I18n.t('helpers.link.delete')
    end

    assert_text I18n.t('helpers.notice.delete')
    page.assert_current_path(transports_path)
  end
end
