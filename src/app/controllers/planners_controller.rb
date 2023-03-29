class PlannersController < ApplicationController
  
  def index
  end

  def new
    @planner = Planner.new
  end

  def create
    @planner = Planner.new(planner_params)
    # 画像登録処理
    image = params[:planner][:planner_image]
    hash = SecureRandom.hex(10)
    @planner.planner_image = "#{@planner.name}_#{hash}.jpg" if image
    if @planner.save
      reset_session
      log_in_planner @planner
      flash[:info] = "マイページへようこそ"
      redirect_to @planner
    else
      @planner.planner_image = image if image
      render 'new', status: :unprocessable_entity
    end
  end

  def show
    @planner = Planner.find(params[:id])
  end

  private

  def planner_params
    params.require(:planner).permit(:name, :email, :planner_image, :password,
                                    :discription, :password_confirmation)
  end
end
