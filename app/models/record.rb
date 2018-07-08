class Record < ApplicationRecord
  belongs_to :division
  belongs_to :person

  validates :date, presence: true
  validates :cost, presence: true, numericality:
      {only_integer: true, greater_than_or_equal_to: 0}

  def hospital
    division if division && division.type == Hospital.model_name
  end

  def drugstore
    division if division && division.type == Drugstore.model_name
  end

  def transport
    division if division && division.type == Transport.model_name
  end

  def create_self_and_transports!
    transaction do
      save!
      hospital_transports = hospital&.hospital_transports
      return self unless hospital_transports

      params = {person: person, date: date}
      ret = [self]
      hospital_transports.each do |ht|
        ret << Record.create!(params.merge(cost: ht.transport_cost,
                                           division: ht.transport))
      end
      ret
    end
  end

  def create_self_and_transports
    create_self_and_transports!
  rescue ActiveRecord::RecordInvalid
    false
  end

  def self.search(opt)
    opt ||= {}
    ret = includes(:person).includes(:division).joins(:division)
    ret = ret.where(person_id: opt[:name]) if opt[:name].present?
    ret = ret.where('divisions.type = ?', opt[:division_type]) if opt[:division_type].present?
    ret = ret.where(division_id: opt[:division_id]) if opt[:division_id].present?
    ret = ret.where('date >= ?', opt[:from_date]) if opt[:from_date].present?
    ret = ret.where('date <= ?', opt[:to_date]) if opt[:to_date].present?
    ret.order(:date)
  end
end
