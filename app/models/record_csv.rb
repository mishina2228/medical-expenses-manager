require 'csv'

class RecordCSV
  HEADERS = [:date, :person_name, :division, :division_name, :cost].freeze

  def self.export(records, encode)
    csv_string = CSV.generate do |csv|
      csv << HEADERS
      records.each do |record|
        csv << record_columns(record)
      end
    end
    csv_string.encode(encode)
  end

  def self.record_columns(record)
    [
      record.date,
      record.person.name,
      record.division.model_name.human,
      record.division.name,
      record.cost
    ]
  end
end