class HospitalsController < ApplicationController
  before_action :set_hospital, only: [:show, :edit, :update, :destroy]

  def index
    @hospitals = Hospital.paginate(params)
  end

  def show
  end

  def new
    @hospital = Hospital.new
  end

  def edit
  end

  def create
    @hospital = Hospital.new(hospital_params)

    respond_to do |format|
      if @hospital.save
        format.html {redirect_to hospitals_url, notice: t('helpers.notice.create')}
        format.json {render :show, status: :created, location: @hospital}
      else
        format.html {render :new}
        format.json {render json: @hospital.errors, status: :unprocessable_entity}
      end
    end
  end

  def update
    respond_to do |format|
      if @hospital.update(hospital_params)
        format.html {redirect_to hospitals_url, notice: t('helpers.notice.update')}
        format.json {render :show, status: :ok, location: @hospital}
      else
        format.html {render :edit}
        format.json {render json: @hospital.errors, status: :unprocessable_entity}
      end
    end
  end

  def destroy
    @hospital.destroy
    respond_to do |format|
      format.html {redirect_to hospitals_url, notice: t('helpers.notice.delete')}
      format.json {head :no_content}
    end
  end

  private

  def set_hospital
    @hospital = Hospital.find(params[:id])
  end

  def hospital_params
    params.require(:hospital).permit(:name)
  end
end
