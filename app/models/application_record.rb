class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.objects_for_select
    all.map {|o| [o.name, o.id]}
  end
end
