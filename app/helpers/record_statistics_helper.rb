module RecordStatisticsHelper
  def check_division(division, klass)
    icon = division.instance_of?(klass) ? 'fa-check-square' : 'fa-square'
    tag.span class: ['far', icon]
  end

  def render_division_for_statistics(division)
    case division
    when Drugstore
      t('text.division_types.drug')
    when Transport
      t('text.division_types.other')
    when Hospital
      t('text.division_types.medical_treatment')
    end
  end
end
