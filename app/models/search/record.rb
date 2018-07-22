class Search::Record < Search::Base
  attr_accessor :ids, :division_id, :division_type, :name,
                :from_date, :to_date

  def search
    ret = ::Record.includes(:person).includes(:division).joins(:division)
    ret = ret.where(id: ids) if ids.present?
    ret = ret.where(person_id: name) if name.present?
    ret = ret.where('divisions.type = ?', division_type) if division_type.present?
    ret = ret.where(division_id: division_id) if division_id.present?
    ret = ret.where('date >= ?', from_date) if from_date.present?
    ret = ret.where('date <= ?', to_date) if to_date.present?
    ret.order(:date)
  end
end
