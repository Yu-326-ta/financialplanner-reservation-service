class ClientsController < ApplicationController
  def index
  end
  
  def new
    @client = Client.new
  end

  def create
    @client = Client.new(client_params)
    if @client.save
      flash[:info] = "マイページへようこそ"
      redirect_to clients_path
    else
      render 'new', status: :unprocessable_entity
    end
  end
  
  private

  def client_params
    params.require(:client).permit(:name, :email, :password,
                                   :password_confirmation)
  end
end
