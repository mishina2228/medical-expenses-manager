module RecordStatisticsHelper
  def check_division(division, klass)
    division.class == klass ? 'glyphicon-check' : 'glyphicon-unchecked'
  end

  def render_division(division)
    case division.class.to_s
    when Drugstore.to_s
      t('text.division_types.drug')
    when Transport.to_s
      t('text.division_types.other')
    when Hospital.to_s
      t('text.division_types.medical_treatment')
    end
  end
end
