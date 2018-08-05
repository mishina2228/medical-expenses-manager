class Drugstore < Division
  has_many :records, foreign_key: :division_id, inverse_of: :drugstore, dependent: :destroy
end
