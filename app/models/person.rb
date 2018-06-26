class Person < ApplicationRecord
  has_many :records, dependent: :destroy

  validates :name, presence: true, uniqueness: {scope: :relationship}
  validates :relationship, presence: true
end
