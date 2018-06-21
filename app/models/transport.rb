class Transport < Division
  has_many :hospital_transports, dependent: :destroy
  has_many :hospitals, through: :hospital_transports
end
