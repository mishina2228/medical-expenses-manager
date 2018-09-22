class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.objects_for_select
    all.map {|o| [o.name, o.id]}
  end

  def self.paginate(params)
    page(params[:page]).per(params[:per])
  end
end
