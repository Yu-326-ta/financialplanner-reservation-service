class ReservationsController < ApplicationController
  def new
    @reservation = Reservation.new
    @planner = Planner.find(params[:planner_id])
    @day = params[:day]
    @time = params[:time]
    @planner_id = params[:planner_id]
    @start_time = DateTime.parse(@day + " " + @time + " " + "JST")

    message = Reservation.check_reservation_day(@day.to_date)
    if !!message
      redirect_to reservation_path(@planner.id), flash: { danger: message }
    end
  end

  def show
    @planner = Planner.find(params[:id])
    @reservations = @planner.reservations.where("day >= ?", Date.current).where("day < ?", Date.current >> 3).order(day: :desc)
  end

  def create
    @reservation = Reservation.new(reservation_params)
    if @reservation.save
      flash[:info] = "予約が完了しました"
      redirect_to client_path(@reservation.client_id)
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def destroy
    @reservation = Reservation.find(params[:client_id])
    if @reservation.destroy
      flash[:success] = "予約を削除しました。"
      redirect_to client_path(@reservation.client_id)
    else
      render 'show', flash: { error: "予約の削除に失敗しました" }
    end
  end

  private
  def reservation_params
    params.require(:reservation).permit(:day, :time, :client_id, :planner_id, :start_time)
  end
end
