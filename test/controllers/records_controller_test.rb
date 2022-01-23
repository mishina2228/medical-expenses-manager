require 'test_helper'

class RecordsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @record = records(:record1)
  end

  test 'should get index' do
    get records_url
    assert_response :success
  end

  test 'should get records that match the search conditions' do
    get search_records_url(search_record: {division_type: 'Hospital', to_date: Date.current})
    assert_response :success

    get search_records_url # no params
    assert_response :success
  end

  test 'should show a record' do
    get record_url(id: @record)
    assert_response :success
  end

  test 'should get new' do
    get new_record_url
    assert_response :success
  end

  test 'should redirect to index when trying to get new without any Person' do
    Person.delete_all
    get new_record_url

    assert_response :redirect
    assert_redirected_to records_url
  end

  test 'should create a record' do
    Record.delete_all
    assert_equal 2, @record.hospital.hospital_transports.size

    assert_difference -> {Record.count}, 3 do
      post records_url,
           params: {
             record: {
               cost: @record.cost,
               date: @record.date,
               person_id: @record.person_id,
               division_id: @record.division_id
             }
           }
    end

    assert_response :redirect
    assert_redirected_to records_url
    assert_includes flash[:notice], I18n.t('helpers.notice.create')
    assert_includes flash[:notice], I18n.t('helpers.notice.transport_created')
  end

  test 'should create records continuously when continuous parameter is given' do
    Record.delete_all
    assert_equal 2, @record.hospital.hospital_transports.size
    record_params = {
      record: {
        cost: @record.cost,
        date: @record.date,
        person_id: @record.person_id,
        division_id: @record.division_id
      }
    }

    assert_difference -> {Record.count}, 3 do
      post records_url, params: record_params.merge(continuous: true)
    end

    assert_response :redirect
    assert_redirected_to new_record_url(record_params)
  end

  test 'should not create a record unless parameters are valid' do
    @record.date = nil
    assert @record.invalid?

    assert_no_difference -> {Record.count} do
      post records_url,
           params: {
             record: {
               cost: @record.cost,
               date: @record.date,
               person_id: @record.person_id,
               division_id: @record.division_id
             }
           }
    end

    assert_response :unprocessable_entity
  end

  test 'should redirect to index when trying to create a record without any Person' do
    Person.delete_all
    post records_url

    assert_response :redirect
    assert_redirected_to records_url
  end

  test 'should get edit' do
    get edit_record_url(id: @record)
    assert_response :success
  end

  test 'should redirect to index when trying to edit a record without any Person' do
    Person.delete_all
    get edit_record_url(id: @record)

    assert_response :redirect
    assert_redirected_to records_url
  end

  test 'should update a record' do
    patch record_url(id: @record),
          params: {
            record: {
              cost: @record.cost
            }
          }

    assert_response :redirect
    assert_redirected_to records_url
    assert_includes flash[:notice], I18n.t('helpers.notice.update')
  end

  test 'should not update a record unless parameters are valid' do
    before_cost = @record.cost
    @record.cost = nil
    assert @record.invalid?

    patch record_url(id: @record),
          params: {
            record: {
              cost: @record.cost
            }
          }

    assert_response :unprocessable_entity
    assert_equal before_cost, @record.reload.cost
  end

  test 'should redirect to index when trying to update a record without any Person' do
    Person.delete_all
    patch record_url(id: @record)

    assert_response :redirect
    assert_redirected_to records_url
  end

  test 'should destroy a record' do
    assert_difference -> {Record.count}, -1 do
      delete record_url(id: @record)
    end

    assert_response :redirect
    assert_redirected_to records_url
    assert_includes flash[:notice], I18n.t('helpers.notice.delete')
  end

  test 'should export records as a CSV' do
    get export_records_path, params: {export: {encoding: 'utf-8', ids: [records(:record1).id, records(:record2).id]}}

    assert_response :success
    assert_equal 3, response.body.lines.size, 'Header and 2 records, the number of lines should be 3.'
    assert_equal 'text/csv', response.headers['Content-Type']
    assert_match(/record_\d{4}\d{2}\d{2}\d{2}\d{2}\d{2}\.csv/, response.headers['Content-Disposition'])
  end

  test 'should load a valid CSV' do
    file = Rack::Test::UploadedFile.new('test/data/test_utf8.csv', 'text/csv')
    put load_csv_records_path, params: {load_csv: {file: file}}

    assert_response :success
  end

  test 'should redirect to the search page when a CSV is not specified' do
    [nil, {}, {load_csv: {}}, {load_csv: {file: nil}}, {load_csv: {file: ''}}].each do |param|
      put load_csv_records_path, params: param

      assert_redirected_to search_records_url
      assert_includes flash[:notice], I18n.t('helpers.notice.load_csv.invalid_format')
    end
  end

  test 'should redirect to the search page when a file other than CSV is specified' do
    file = Rack::Test::UploadedFile.new('test/fixtures/records.yml', 'application/yaml')
    put load_csv_records_path, params: {load_csv: {file: file}}

    assert_redirected_to search_records_url
    assert_includes flash[:notice], I18n.t('helpers.notice.load_csv.invalid_format')
  end

  test 'should redirect to the search page when a invalid CSV is specified' do
    files = [
      Rack::Test::UploadedFile.new('test/data/test_utf8_missing_headers.csv', 'text/csv'),
      Rack::Test::UploadedFile.new('test/data/test_utf8_invalid_values.csv', 'text/csv')
    ]
    files.each do |file|
      put load_csv_records_path, params: {load_csv: {file: file}}

      assert_redirected_to search_records_url
      assert flash[:alert].present?
    end
  end
end
