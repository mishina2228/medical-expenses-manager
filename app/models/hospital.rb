class Hospital < ApplicationRecord
  has_many :hospital_transportation, dependent: :destroy
  has_many :transportation, through: :hospital_transportation

  validates :name, presence: true
  validates :expense, presence: true, numericality:
      {only_integer: true, greater_than_or_equal_to: 0}
end
