module ReservationsHelper
  def times
    times = ["10:00",
             "10:30",
             "11:00",
             "11:30",
             "12:00",
             "12:30",
             "13:00",
             "13:30",
             "14:00",
             "14:30",
             "15:00",
             "15:30",
             "16:00",
             "16:30",
             "17:00",
             "17:30"]
  end

  def check_reservation(reservations, day, time)
    result = false
    reservations.each do |reservation|
      result = reservation[:day].strftime("%Y-%m-%d").eql?(day.strftime("%Y-%m-%d")) && reservation[:time].eql?(time) && reservation[:planner_id].eql?(params[:id].to_i)
      return result if result
    end

    return result
  end
end
 