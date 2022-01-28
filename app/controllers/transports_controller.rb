class TransportsController < ApplicationController
  before_action :set_transport, only: [:show, :edit, :update, :destroy]

  def index
    @transports = Transport.paginate(params)
  end

  def show
  end

  def new
    @transport = Transport.new
  end

  def edit
  end

  def create
    @transport = Transport.new(transport_params)

    respond_to do |format|
      if @transport.save
        format.html {redirect_to transports_url, notice: t('helpers.notice.create')}
        format.json {render :show, status: :created, location: @transport}
      else
        format.html {render :new, status: :unprocessable_entity}
        format.json {render json: @transport.errors, status: :unprocessable_entity}
      end
    end
  end

  def update
    respond_to do |format|
      if @transport.update(transport_params)
        format.html {redirect_to transports_url, notice: t('helpers.notice.update')}
        format.json {render :show, status: :ok, location: @transport}
      else
        format.html {render :edit, status: :unprocessable_entity}
        format.json {render json: @transport.errors, status: :unprocessable_entity}
      end
    end
  end

  def destroy
    @transport.destroy
    respond_to do |format|
      format.html {redirect_to transports_url, notice: t('helpers.notice.delete'), status: :see_other}
      format.json {head :no_content}
    end
  end

  private

  def set_transport
    @transport = Transport.find(params[:id])
  end

  def transport_params
    params.require(:transport).permit(:name)
  end
end
