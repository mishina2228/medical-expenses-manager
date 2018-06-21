class Transportation < ApplicationRecord
  has_many :hospital_transportation, dependent: :destroy
  has_many :hospitals, through: :hospital_transportation

  validates :name, presence: true
end
