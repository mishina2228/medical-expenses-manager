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
      return true unless hospital_transports

      params = {person: person, date: date}
      hospital_transports.each do |ht|
        Record.create!(params.merge(cost: ht.transport_cost,
                                    division: ht.transport))
      end
      true
    end
  end

  def create_self_and_transports
    create_self_and_transports!
  rescue ActiveRecord::RecordInvalid
    false
  end
end
