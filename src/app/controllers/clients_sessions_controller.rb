class ClientsSessionsController < ApplicationController
  include ClientsSessionsHelper
  def new
  end
  
  def create
    client = Client.find_by(email: params[:clients_session][:email].downcase)
    if client && client.authenticate(params[:clients_session][:password])
      reset_session
      params[:clients_session][:remember_me] == '1' ? remember_client(client) : forget_client(client)
      log_in_client client
      redirect_to client
    else
      flash.now[:danger] = 'メールアドレスまたはパスワードが有効ではありません'
      render 'new', status: :unprocessable_entity
    end
  end

  def destroy
    log_out_client if logged_in_client?
    redirect_to root_url, status: :see_other
  end
end
