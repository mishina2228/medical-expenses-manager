require 'csv'

class RecordCSV
  include ActiveModel::Model

  attr_accessor :date, :person_name, :division, :division_name, :cost

  validates :date, presence: true
  validates :person_name, presence: true
  validates :division, presence: true
  validates :division_name, presence: true
  validates :cost, presence: true, numericality:
    {only_integer: true, greater_than_or_equal_to: 0}

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

  def self.load(csv_path, encoding = 'utf-8')
    records = nil

    begin
      records = CSV.table(csv_path, encoding: encoding)
    rescue Encoding::UndefinedConversionError, Encoding::InvalidByteSequenceError
      raise ArgumentError, I18n.t('helpers.notice.load_csv.encoding_error.utf8_to_sjis')
    rescue ArgumentError
      raise ArgumentError, I18n.t('helpers.notice.load_csv.encoding_error.sjis_to_utf8')
    end

    raise ArgumentError, I18n.t('helpers.notice.load_csv.invalid_headers') unless headers?(records)
    records.map {|r| new_from_cvs(r)}
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

  def self.headers?(table)
    table.headers == HEADERS
  end

  def self.new_from_cvs(record)
    new(date: record[:date],
        person_name: record[:person_name],
        division: record[:division],
        division_name: record[:division_name],
        cost: record[:cost])
  end
end
