# frozen_string_literal: true

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
    else
      [per, MAX_PER].min
    end
  end
end
