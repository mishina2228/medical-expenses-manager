class DrugstoresController < ApplicationController
  before_action :set_drugstore, only: [:show, :edit, :update, :destroy]

  # GET /drugstores
  # GET /drugstores.json
  def index
    @drugstores = Drugstore.all
  end

  # GET /drugstores/1
  # GET /drugstores/1.json
  def show
  end

  # GET /drugstores/new
  def new
    @drugstore = Drugstore.new
  end

  # GET /drugstores/1/edit
  def edit
  end

  # POST /drugstores
  # POST /drugstores.json
  def create
    @drugstore = Drugstore.new(drugstore_params)

    respond_to do |format|
      if @drugstore.save
        format.html { redirect_to @drugstore, notice: 'Drugstore was successfully created.' }
        format.json { render :show, status: :created, location: @drugstore }
      else
        format.html { render :new }
        format.json { render json: @drugstore.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /drugstores/1
  # PATCH/PUT /drugstores/1.json
  def update
    respond_to do |format|
      if @drugstore.update(drugstore_params)
        format.html { redirect_to @drugstore, notice: 'Drugstore was successfully updated.' }
        format.json { render :show, status: :ok, location: @drugstore }
      else
        format.html { render :edit }
        format.json { render json: @drugstore.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /drugstores/1
  # DELETE /drugstores/1.json
  def destroy
    @drugstore.destroy
    respond_to do |format|
      format.html { redirect_to drugstores_url, notice: 'Drugstore was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_drugstore
      @drugstore = Drugstore.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def drugstore_params
      params.require(:drugstore).permit(:name)
    end
end
