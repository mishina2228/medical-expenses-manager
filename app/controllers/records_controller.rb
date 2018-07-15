class RecordsController < ApplicationController
  before_action :set_record, only: [:show, :edit, :update, :destroy]
  before_action -> {require_data(records_url, Person)},
                only: [:new, :create, :edit, :update]

  def index
    opt = params[:record]&.permit(:division_id)
    @records = Record.search(search_params&.merge(opt))
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
        format.html {redirect_to records_url, notice: t('helpers.notice.create')}
        format.json {render :show, status: :created, location: @record}
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
        format.json {render :show, status: :ok, location: @record}
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
    encoding = params[:export][:encode]
    filename = "record_#{Time.zone.now.strftime('%Y%m%d%H%M%S')}.csv"
    records = Record.search(params[:export])
    csv_data = RecordCSV.export(records, encoding)
    send_data csv_data, filename: filename, type: 'text/csv'
  end

  private

  def set_record
    @record = Record.find(params[:id])
  end

  def record_params
    params.require(:record).permit(:cost, :date, :transport_cost, :person_id, :division_id)
  end

  def search_params
    params[:search]&.permit(:name, :division_type, :from_date, :to_date)
  end
end
