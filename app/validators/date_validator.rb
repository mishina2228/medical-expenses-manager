class DateValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    Date.parse(value)
  rescue
    record.errors[attribute] << I18n.t('activerecord.errors.messages.date_invalid')
  end
end