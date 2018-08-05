class Person < ApplicationRecord
  acts_as_paranoid

  has_many :records, dependent: :destroy

  validates :name, presence: true, uniqueness: {scope: :relationship}
  validates :relationship, presence: true
end
