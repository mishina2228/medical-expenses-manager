# frozen_string_literal: true

require 'test_helper'

class RecordStatisticsControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get record_statistics_url
    assert_response :success
  end
end
