# frozen_string_literal: true

require 'test_helper'

class DivisionTest < ActiveSupport::TestCase
  test 'division_names' do
    actual = Division.division_names
    expected = {
      'Drugstore' => I18n.t('activerecord.models.drugstore'),
      'Hospital' => I18n.t('activerecord.models.hospital'),
      'Transport' => I18n.t('activerecord.models.transport')
    }

    assert_equal expected, actual
  end
end
