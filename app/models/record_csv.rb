require 'csv'

class RecordCSV
  HEADERS = [:date, :person_name, :division, :division_name, :cost].freeze

  def self.export(records, encoding)
    csv_string = CSV.generate do |csv|
      csv << HEADERS
      records.each do |record|
        csv << record_columns(record)
      end
    end
    csv_string.encode(encoding)
  end

  def self.load_csv(csv_path, encoding)
    CSV.table(csv_path, encoding: encoding)
  end

  def self.record_columns(record)
    [
      record.date,
      record.person.name,
      record.division.model_name,
      record.division.name,
      record.cost
    ]
  end
end