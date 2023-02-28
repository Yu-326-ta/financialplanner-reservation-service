class PlannersSessionsController < ApplicationController
  
  def new
  end

  def create
    planner = Planner.find_by(email: params[:planners_session][:email].downcase)
    if planner && planner.authenticate(params[:planners_session][:password])
      reset_session
      log_in_planner planner
      redirect_to planners_path
    else
      flash.now[:danger] = 'メールアドレスまたはパスワードが有効ではありません'
      render 'new', status: :unprocessable_entity
    end
  end

  def destroy
    log_out_planner
    redirect_to root_url, status: :see_other
  end
end
