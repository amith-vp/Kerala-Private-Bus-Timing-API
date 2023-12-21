require 'time'

class Api::V1::testController < ApplicationController
  def index
    departure_station = params[:departure]
    destination_station = params[:destination]
    time_param = params[:time]
    exclude_param = params[:exclude]
    time = time_param.present? ? Time.parse(time_param) : nil
    exclude = exclude_param.present? ? exclude_param.downcase == 'true' : false
  
    if departure_station.present? && destination_station.present?
      # all schedules with both dep and dest
      schedules = Schedule.joins(:stations)
                          .where(stations: { name: [departure_station, destination_station] })
                          .group('schedules.id')
                          .having('COUNT(DISTINCT stations.name) = 2')
                          .distinct
                          .includes(:stations, route: :bus_schedule)
      puts schedules
  
      trips = []
      schedules.each do |schedule|
        stations = schedule.stations.order(:id)
        station_names = stations.map(&:name)

        #  check if dep station comes before dest station using index
        departure_index = station_names.find_index(departure_station)
        destination_index = station_names.find_index(destination_station)

        if departure_index && destination_index && departure_index < destination_index
          departure_station_data = stations[departure_index]
          departure_time = Time.parse(departure_station_data.departure_time)

          # Skip this trip if a time parameter was provided and the departure time is before the provided time
          next if time && departure_time < time

          trip_data = {
            vehicle_number: schedule.route.bus_schedule.vehicle_number,
            trip: schedule.trip,
            stations: stations.map do |station| 
              {
                station: station.name,
                arrivalTime: station.arrival_time,
                departureTime: station.departure_time
              }
            end
          }

          # Exclude stations before departure and after destination if exclude parameter is true
          if exclude
            trip_data[:stations] = trip_data[:stations][departure_index..destination_index]
          end
  
          trips << trip_data
        end
      end
  
      # sort based on dep time of dep station
      sorted_trips = trips.sort_by do |trip|
        time_str = trip[:stations].find { |station| station[:station] == departure_station }[:departureTime]
        Time.parse(time_str) # 12-h am/pm format
      end
      render json: sorted_trips, status: :ok
  
    else
      render json: { error: 'Departure and destination stations are required.' }, status: :unprocessable_entity
    end
  end
end