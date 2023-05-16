module ReservationsHelper
  def times_array
    frames_number = 16
    start_at = '10:00'
    frames_number.times.map { |frame| (Time.parse(start_at) + 30.minutes * frame).strftime('%H:%M') }
  end

  def check_reservation(reservations, day, time)
    result = false
    reservations.each do |reservation|
      result = reservation[:day].strftime('%Y-%m-%d').eql?(day.strftime('%Y-%m-%d')) && reservation[:time].eql?(time) && reservation[:planner_id].eql?(params[:id].to_i)
      return result if result
    end

    result
  end

  def check_saturday_reservation(day, time)
    day.saturday? && ['10:00', '10:30', '15:00', '15:30', '16:00', '16:30', '17:00', '17:30'].include?(time)
  end
end
