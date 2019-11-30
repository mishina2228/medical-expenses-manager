class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  DEFAULT_PER = 30
  MAX_PER = 50

  def self.paginate(params)
    page(params[:page]).per(proper_per(params[:per]))
  end

  def self.proper_per(per)
    per = per.to_i
    if per <= 0
      DEFAULT_PER
    elsif per > MAX_PER
      MAX_PER
    else
      per
    end
  end
end
