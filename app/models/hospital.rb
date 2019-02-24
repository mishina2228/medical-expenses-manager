class Hospital < Division
  has_many :hospital_transports, dependent: :destroy
  accepts_nested_attributes_for :hospital_transports, allow_destroy: true

  has_many :transports, through: :hospital_transports
  has_many :records, foreign_key: :division_id, inverse_of: :hospital, dependent: :destroy
end
