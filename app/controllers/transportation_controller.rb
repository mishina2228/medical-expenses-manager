class TransportationController < ApplicationController
  before_action :set_transportation, only: [:show, :edit, :update, :destroy]

  # GET /transportation
  # GET /transportation.json
  def index
    @transportation = Transportation.all
  end

  # GET /transportation/1
  # GET /transportation/1.json
  def show
  end

  # GET /transportation/new
  def new
    @transportation = Transportation.new
  end

  # GET /transportation/1/edit
  def edit
  end

  # POST /transportation
  # POST /transportation.json
  def create
    @transportation = Transportation.new(transportation_params)

    respond_to do |format|
      if @transportation.save
        format.html { redirect_to @transportation, notice: 'Transportation was successfully created.' }
        format.json { render :show, status: :created, location: @transportation }
      else
        format.html { render :new }
        format.json { render json: @transportation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transportation/1
  # PATCH/PUT /transportation/1.json
  def update
    respond_to do |format|
      if @transportation.update(transportation_params)
        format.html { redirect_to @transportation, notice: 'Transportation was successfully updated.' }
        format.json { render :show, status: :ok, location: @transportation }
      else
        format.html { render :edit }
        format.json { render json: @transportation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transportation/1
  # DELETE /transportation/1.json
  def destroy
    @transportation.destroy
    respond_to do |format|
      format.html { redirect_to transportation_index_url, notice: 'Transportation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transportation
      @transportation = Transportation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def transportation_params
      params.require(:transportation).permit(:name)
    end
end
