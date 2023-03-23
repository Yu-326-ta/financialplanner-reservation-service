class ReservationsController < ApplicationController
  def new
    @reservation = Reservation.new
    @planner = Planner.find(params[:planner_id])
    @day = params[:day]
    @time = params[:time]
    @planner_id = params[:planner_id]
    @start_time = DateTime.parse(@day + " " + @time + " " + "JST")
  end

  def show
    @planner = Planner.find(params[:id])
    @reservations = @planner.reservations.where("day >= ?", Date.current).where("day < ?", Date.current >> 3).order(day: :desc)
  end

  def create
    @reservation = Reservation.new(reservation_params)
    if @reservation.save
      redirect_to client_path @reservation.id
    else
      render :new
    end
  end

  private
  def reservation_params
    params.require(:reservation).permit(:day, :time, :client_id, :planner_id, :start_time)
  end
end
