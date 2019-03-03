class DivisionValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless Division.division_names.key?(value)
      record.errors[attribute] << I18n.t('activerecord.errors.messages.division_invalid')
    end
  end
end
