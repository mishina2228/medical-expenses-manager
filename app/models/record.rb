class Record < ApplicationRecord
  acts_as_paranoid

  belongs_to :division
  belongs_to :person
  belongs_to :hospital, foreign_key: :division_id, inverse_of: :records, optional: true
  belongs_to :drugstore, foreign_key: :division_id, inverse_of: :records, optional: true
  belongs_to :transport, foreign_key: :division_id, inverse_of: :records, optional: true

  validates :date, presence: true
  validates :cost, presence: true, numericality:
    {only_integer: true, greater_than_or_equal_to: 0}

  def create_self_and_transports!
    transaction do
      save!
      hospital_transports = hospital&.hospital_transports
      return self unless hospital_transports

      ret = [self]
      hospital_transports.each do |ht|
        ret << Record.create!(
          person: person, date: date, cost: ht.transport_cost, division: ht.transport
        )
      end
      ret
    end
  end

  def create_self_and_transports
    create_self_and_transports!
  rescue ActiveRecord::RecordInvalid
    false
  end
end
