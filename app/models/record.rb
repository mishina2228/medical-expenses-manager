class Record < ApplicationRecord
  belongs_to :division
  belongs_to :person

  validates :date, presence: true
  validates :cost, presence: true, numericality:
      {only_integer: true, greater_than_or_equal_to: 0}
end
