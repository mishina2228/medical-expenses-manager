class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.objects_for_select
    all.map {|o| [o.name, o.id]}
  end

  def self.paginate(params)
    per = params[:per] || 30
    page(params[:page]).per(per)
  end
end
