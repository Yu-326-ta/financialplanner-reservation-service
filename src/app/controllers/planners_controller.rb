class PlannersController < ApplicationController
  
  def index
  end

  def new
    @planner = Planner.new
  end

  def create
    @planner = Planner.new(planner_params)
    if @planner.save
      flash[:info] = "マイページへようこそ"
      redirect_to planners_path
    else
      render 'new', status: :unprocessable_entity
    end
  end

  private

  def planner_params
    params.require(:planner).permit(:name, :email, :password,
                                    :discription, :password_confirmation)
  end
end
