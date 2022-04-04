# frozen_string_literal: true

class DateValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    Date.parse(value.to_s)
  rescue ArgumentError
    record.errors.add(attribute, I18n.t('activerecord.errors.messages.date_invalid'))
  end
end
