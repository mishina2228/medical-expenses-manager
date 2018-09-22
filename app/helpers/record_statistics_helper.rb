module RecordStatisticsHelper
  def check_division(division, klass)
    division.class == klass ? 'glyphicon-check' : 'glyphicon-unchecked'
  end
end
