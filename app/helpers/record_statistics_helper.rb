module RecordStatisticsHelper
  def check_division(division, klass)
    icon = division.instance_of?(klass) ? 'glyphicon-check' : 'glyphicon-unchecked'
    tag.span class: ['glyphicon', icon]
  end

  def render_division_for_statistics(division)
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
