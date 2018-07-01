class Division < ApplicationRecord
  validates :name, presence: true, uniqueness: {scope: :type}

  def self.division_names
    @division_names ||= {Drugstore.model_name => Drugstore.model_name.human,
                         Hospital.model_name => Hospital.model_name.human,
                         Transport.model_name => Transport.model_name.human}
  end
end
