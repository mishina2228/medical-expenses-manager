# frozen_string_literal: true

class RecordStatisticsController < ApplicationController
  def index
    @year = params[:year] || Date.current.year
    @record_statistics = Record.annual_statistics(@year)
  end
end
