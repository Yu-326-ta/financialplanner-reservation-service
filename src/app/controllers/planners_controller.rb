class PlannersController < ApplicationController
  
  def index
  end

  def new
    @planner = Planner.new
  end

  def create
    @planner = Planner.new(planner_params)
    if @planner.save
      reset_session
      log_in_planner @planner
      flash[:info] = "マイページへようこそ"
      redirect_to @planner
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def show
    @planner = Planner.find(params[:id])
  end

  private

  def planner_params
    params.require(:planner).permit(:name, :email, :password,
                                    :discription, :password_confirmation)
  end
end
