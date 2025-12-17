# frozen_string_literal: true

class HospitalsController < ApplicationController
  before_action :set_hospital, only: [:edit, :update, :destroy]
  before_action :set_hospital_with_transport, only: [:show]

  def index
    @hospitals = Hospital.includes(hospital_transports: :transport)
                         .paginate(params)
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
        format.html {render :new, status: :unprocessable_content}
        format.json {render json: @hospital.errors, status: :unprocessable_content}
      end
    end
  end

  def update
    respond_to do |format|
      if @hospital.update(hospital_params)
        format.html {redirect_to hospitals_url, notice: t('helpers.notice.update')}
        format.json {render :show, status: :ok, location: @hospital}
      else
        format.html {render :edit, status: :unprocessable_content}
        format.json {render json: @hospital.errors, status: :unprocessable_content}
      end
    end
  end

  def destroy
    @hospital.destroy
    respond_to do |format|
      format.html {redirect_to hospitals_url, notice: t('helpers.notice.delete'), status: :see_other}
      format.json {head :no_content}
    end
  end

  private

  def set_hospital
    @hospital = Hospital.find(params[:id])
  end

  def set_hospital_with_transport
    @hospital = Hospital.includes(hospital_transports: :transport)
                        .find(params[:id])
  end

  def hospital_params
    permitted = [
      :name,
      {hospital_transports_attributes: [[
        :id, :_destroy, :transport_id, :transport_cost
      ]]}
    ]
    params.expect(hospital: permitted)
  end
end
