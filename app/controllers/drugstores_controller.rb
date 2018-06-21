class DrugstoresController < ApplicationController
  before_action :set_drugstore, only: [:show, :edit, :update, :destroy]

  def index
    @drugstores = Drugstore.all
  end

  def show
  end

  def new
    @drugstore = Drugstore.new
  end

  def edit
  end

  def create
    @drugstore = Drugstore.new(drugstore_params)

    respond_to do |format|
      if @drugstore.save
        format.html {redirect_to drugstores_url, notice: t('helpers.notice.create')}
        format.json {render :show, status: :created, location: @drugstore}
      else
        format.html {render :new}
        format.json {render json: @drugstore.errors, status: :unprocessable_entity}
      end
    end
  end

  def update
    respond_to do |format|
      if @drugstore.update(drugstore_params)
        format.html {redirect_to drugstores_url, notice: t('helpers.notice.update')}
        format.json {render :show, status: :ok, location: @drugstore}
      else
        format.html {render :edit}
        format.json {render json: @drugstore.errors, status: :unprocessable_entity}
      end
    end
  end

  def destroy
    @drugstore.destroy
    respond_to do |format|
      format.html {redirect_to drugstores_url, notice: t('helpers.notice.delete')}
      format.json {head :no_content}
    end
  end

  private

  def set_drugstore
    @drugstore = Drugstore.find(params[:id])
  end

  def drugstore_params
    params.require(:drugstore).permit(:name)
  end
end
