class ClientsController < ApplicationController
  include ClientsSessionsHelper
  def index
    @planners = Planner.all.page(params[:page]).per(10)
  end

  def new
    @client = Client.new
  end

  def create
    @client = Client.new(client_params)
    # 画像登録処理
    image = params[:client][:client_image]
    hash = SecureRandom.hex(10)
    @client.client_image = "#{@client.name}_#{hash}.jpg" if image
    if @client.save
      reset_session
      log_in_client @client
      flash[:info] = 'マイページへようこそ'
      redirect_to clients_path
    else
      @client.client_image = image if image
      render 'new', status: :unprocessable_entity
    end
  end

  def show
    @client = Client.find(params[:id])
    @client_reservations = @client.reservations.where('start_time >= ?', DateTime.current).order(day: :desc)
    @visit_historys = @client.reservations.where('start_time < ?', DateTime.current).where('start_time > ?',
                                                                                           DateTime.current << 12).order(day: :desc).limit(5)
  end

  private

  def client_params
    params.require(:client).permit(:name, :email, :password,
                                   :password_confirmation)
  end
end
