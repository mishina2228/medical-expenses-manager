class Patient < ApplicationRecord
  has_many :records, dependent: :destroy

  validates :name, presence: true
  validates :relationship, presence: true
end
