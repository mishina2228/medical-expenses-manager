class Record < ApplicationRecord
  acts_as_paranoid

  validates :date, presence: true

  belongs_to :person
  belongs_to :division
  belongs_to :hospital, foreign_key: :division_id, inverse_of: :records, optional: true
  belongs_to :drugstore, foreign_key: :division_id, inverse_of: :records, optional: true
  belongs_to :transport, foreign_key: :division_id, inverse_of: :records, optional: true

  validates :cost, presence: true, numericality:
    {only_integer: true, greater_than_or_equal_to: 0}

  def create_self_and_transports!
    ret = []
    transaction do
      save!
      ret << self
      hospital_transports = hospital&.hospital_transports
      next unless hospital_transports

      hospital_transports.each do |ht|
        ret << Record.create!(
          person: person, date: date, cost: ht.transport_cost, division: ht.transport
        )
      end
    end
    ret
  end

  def create_self_and_transports
    create_self_and_transports!
  rescue ActiveRecord::RecordInvalid
    false
  end

  def self.annual_statistics(year = nil)
    year ||= Time.current.year
    year_date = Date.new(year.to_i)
    Record.where(date: year_date.all_year)
          .group(:person_id)
          .group(:division_id)
          .select('person_id, division_id, sum(cost) as sum_cost')
          .includes(:person)
          .includes(:division)
  end

  def division_type
    division&.type
  end
end
