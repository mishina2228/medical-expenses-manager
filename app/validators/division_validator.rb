# frozen_string_literal: true

class DivisionValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if Division.division_names.key?(value)

    record.errors.add(attribute, I18n.t('activerecord.errors.messages.division_invalid'))
  end
end
