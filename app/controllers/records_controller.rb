# frozen_string_literal: true

class RecordsController < ApplicationController
  before_action :set_record, only: [:show, :edit, :update, :destroy]
  before_action -> {require_data(records_url, Person)},
                only: [:new, :create, :edit, :update]
  before_action :check_csv, only: :load_csv

  def index
    @record = Search::Record.new
    @records = @record.search.paginate(params)
  end

  def search
    @record = Search::Record.new(search_params)
    @records = @record.search.paginate(params)
  end

  def show
  end

  def new
    @record = Record.new(record_params_for_continue)
  end

  def edit
  end

  def create
    @record = Record.new(record_params)

    respond_to do |format|
      notices = []
      if (ret = @record.create_self_and_transports)
        notices << t('helpers.notice.create')
        notices << t('helpers.notice.transport_created') if ret.size > 1
        if params[:continuous].present?
          notices << t('helpers.notice.continuously_create')
          format.html {redirect_to new_record_url(record: record_params), notice: notices}
        end
        format.html {redirect_to records_url, notice: notices}
      else
        format.html {render :new, status: :unprocessable_content}
        format.json {render json: @record.errors, status: :unprocessable_content}
      end
    end
  end

  def update
    respond_to do |format|
      if @record.update(record_params)
        format.html {redirect_to records_url, notice: t('helpers.notice.update')}
      else
        format.html {render :edit, status: :unprocessable_content}
        format.json {render json: @record.errors, status: :unprocessable_content}
      end
    end
  end

  def destroy
    @record.destroy
    respond_to do |format|
      format.html {redirect_to records_url, notice: t('helpers.notice.delete'), status: :see_other}
      format.json {head :no_content}
    end
  end

  def export
    encoding = params[:export][:encoding]
    filename = "record_#{Time.current.strftime('%Y%m%d%H%M%S')}.csv"
    record = Search::Record.new(export_params)
    records = record.search
    csv_data = RecordCSV.export(records, encoding)
    send_data csv_data, filename: filename, type: 'text/csv'
  end

  def load_csv
    @record_csv = RecordCSV.load(@csv_path)
    render :import
  rescue ArgumentError => e
    Rails.logger.info("ERROR: #{e}")
    redirect_to search_records_url, alert: e.message
  end

  private

  def set_record
    @record = Record.find(params[:id])
  end

  def record_params
    params.expect(record: [:cost, :date, :person_id, :division_id])
  end

  def record_params_for_continue
    params[:record]&.permit(:cost, :date, :person_id, :division_id)
  end

  def search_params
    permitted = [
      :name, :division_id, :division_type, :from_date, :to_date, :month
    ]
    params.fetch(:search_record, {}).permit(permitted)
  end

  def export_params
    params.expect(export: [ids: []])
  end

  def check_csv
    file = params.dig(:load_csv, :file)
    if file.respond_to?(:path)
      @csv_path = file.path
      return if File.extname(@csv_path) == '.csv'
    end

    redirect_to search_records_url, notice: t('helpers.notice.load_csv.invalid_format')
  end
end
