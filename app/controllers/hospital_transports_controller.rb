class HospitalTransportsController < ApplicationController
  before_action :set_hospital_transport, only: [:show, :edit, :update, :destroy]
  before_action -> {require_data(hospital_transports_url, Hospital, Transport)},
                only: [:new, :create, :edit, :update]

  def index
    @hospital_transports = HospitalTransport.includes(:hospital)
                                            .includes(:transport)
                                            .order(:hospital_id)
  end

  def show
  end

  def new
    @hospital_transport = HospitalTransport.new
  end

  def edit
  end

  def create
    @hospital_transport = HospitalTransport.new(hospital_transport_params)

    respond_to do |format|
      if @hospital_transport.save
        format.html {redirect_to hospital_transports_url, notice: t('helpers.notice.create')}
        format.json {render :show, status: :created, location: @hospital_transport}
      else
        format.html {render :new}
        format.json {render json: @hospital_transport.errors, status: :unprocessable_entity}
      end
    end
  end

  def update
    respond_to do |format|
      if @hospital_transport.update(hospital_transport_params)
        format.html {redirect_to hospital_transports_url, notice: t('helpers.notice.update')}
        format.json {render :show, status: :ok, location: @hospital_transport}
      else
        format.html {render :edit}
        format.json {render json: @hospital_transport.errors, status: :unprocessable_entity}
      end
    end
  end

  def destroy
    @hospital_transport.destroy
    respond_to do |format|
      format.html {redirect_to hospital_transports_url, notice: t('helpers.notice.delete')}
      format.json {head :no_content}
    end
  end

  private

  def set_hospital_transport
    @hospital_transport = HospitalTransport.find(params[:id])
  end

  def hospital_transport_params
    params.require(:hospital_transport).permit(:hospital_id, :transport_id, :transport_cost)
  end
end
