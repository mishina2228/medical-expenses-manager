# frozen_string_literal: true

class Transport < Division
  has_many :hospital_transports, dependent: :destroy
  has_many :hospitals, through: :hospital_transports
  has_many :records, foreign_key: :division_id, inverse_of: :hospital, dependent: :destroy
end
