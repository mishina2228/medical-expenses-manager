class Hospital < Division
  has_many :hospital_transports, dependent: :destroy
  has_many :transports, through: :hospital_transports
end
