class HospitalTransportation < ApplicationRecord
  belongs_to :hospital
  belongs_to :transportation
end
