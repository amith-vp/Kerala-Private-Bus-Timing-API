class Api::V1::SearchController < ApplicationController
  def index
    vehicle_number = params[:vehicle_number].upcase.gsub(/\s+/, '') if params[:vehicle_number].present?

    if vehicle_number.present?
      bus_schedule = BusSchedule.where("REPLACE(vehicle_number, ' ', '') = ?", vehicle_number).first

      if bus_schedule.present?
        full_route = bus_schedule.routes.map do |route|
          schedules = route.schedules.includes(:stations)
          schedules.map do |schedule|
            {
              trip: schedule.trip,
              stations: schedule.stations.order(:id).map do |station|
                {
                  station: station.name,
                  arrivalTime: station.arrival_time,
                  departureTime: station.departure_time
                }
              end
            }
          end
        end.flatten

        render json: full_route, status: :ok
      else
        render json: { error: 'No bus found with the provided vehicle number.' }, status: :not_found
      end
    else
      render json: { error: 'Vehicle number is required.' }, status: :unprocessable_entity
    end
  end
end
