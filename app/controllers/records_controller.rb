class RecordsController < ApplicationController
  before_action :set_record, only: [:show, :edit, :update, :destroy]
  before_action -> {require_data(records_url, Person)},
                only: [:new, :create, :edit, :update]
  before_action :check_csv, only: :load_csv

  def index
    @record = Search::Record.new
    @records = @record.search
  end

  def search
    @record = Search::Record.new(search_params)
    @records = @record.search
  end

  def show
  end

  def new
    @record = Record.new
  end

  def edit
  end

  def create
    @record = Record.new(record_params)

    respond_to do |format|
      if @record.create_self_and_transports
        if params[:continuous].present?
          format.html {redirect_to new_record_url, notice: t('helpers.notice.continuous_create')}
        end
        format.html {redirect_to records_url, notice: t('helpers.notice.create')}
      else
        format.html {render :new}
        format.json {render json: @record.errors, status: :unprocessable_entity}
      end
    end
  end

  def update
    respond_to do |format|
      if @record.update(record_params)
        format.html {redirect_to records_url, notice: t('helpers.notice.update')}
      else
        format.html {render :edit}
        format.json {render json: @record.errors, status: :unprocessable_entity}
      end
    end
  end

  def destroy
    @record.destroy
    respond_to do |format|
      format.html {redirect_to records_url, notice: t('helpers.notice.delete')}
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
    @record_csv = RecordCSV.load(@csv_path, params[:load_csv][:encoding])
    render :import
  rescue ArgumentError => e
    Rails.logger.info("ERROR: #{e}")
    redirect_to search_records_url, notice: e.message
  end

  private

  def set_record
    @record = Record.find(params[:id])
  end

  def record_params
    params.require(:record).permit(:cost, :date, :person_id, :division_id)
  end

  def search_params
    params[:search_record]&.permit(:name, :division_id, :division_type, :from_date, :to_date)
  end

  def export_params
    params.require(:export).permit(ids: [])
  end

  def check_csv
    @csv_path = params[:load_csv][:file].path
    return if File.extname(@csv_path) == '.csv'

    redirect_to search_records_url, notice: t('helpers.notice.load_csv.invalid_format')
  end
end
