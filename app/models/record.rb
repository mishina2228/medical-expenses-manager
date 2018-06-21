class Record < ApplicationRecord
  belongs_to :hospital
  belongs_to :patient

  validates :date, presence: true
  validates :cost, presence: true, numericality:
      {only_integer: true, greater_than_or_equal_to: 0}
end
