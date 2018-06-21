class Person < ApplicationRecord
  has_many :records, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :relationship, presence: true
end
