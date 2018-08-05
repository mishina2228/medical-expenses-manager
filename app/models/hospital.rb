class Hospital < Division
  has_many :hospital_transports, dependent: :destroy
  has_many :transports, through: :hospital_transports
  has_many :records, foreign_key: :division_id, inverse_of: :hospital, dependent: :destroy
end
