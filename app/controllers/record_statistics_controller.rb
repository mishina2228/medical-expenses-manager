class RecordStatisticsController < ApplicationController
  def index
    @year = params[:year] || Time.current.year
    @record_statistics = Record.annual_statistics(@year)
  end
end
