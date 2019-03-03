class Division < ApplicationRecord
  acts_as_paranoid

  validates :name, presence: true, uniqueness: {scope: [:type, :deleted_at]}

  def self.division_names
    @division_names ||= {Drugstore.model_name.name => Drugstore.model_name.human,
                         Hospital.model_name.name => Hospital.model_name.human,
                         Transport.model_name.name => Transport.model_name.human}
  end

  def self.all_records(type)
    where(type: type).select(:id, :name)
  end
end
