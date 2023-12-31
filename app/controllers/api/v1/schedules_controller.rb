require 'time'

class Api::V1::SchedulesController < ApplicationController
  def index
    
    # convert the dep and des station names to uppercase and replace underscores with spaces
    departure_station = params[:departure]&.upcase
    destination_station = params[:destination]&.upcase
    
    time = params[:time].present? ? Time.parse(params[:time]) : nil
    exclude = params[:restrict]&.downcase == 'true'

    # select all schedules that have the departure and destination stations
    # and also starting with station name
    # eg : if searching for pala it also return pala private stand , pala ksrtc stand, pala old stand 
    
    if departure_station && destination_station
      schedules = Schedule.joins(:stations)
                    .where("stations.name LIKE ? OR stations.name LIKE ? OR stations.name = ? OR stations.name = ?", "#{departure_station} %", "#{destination_station} %", "#{departure_station}", "#{destination_station}")
                    .select('schedules.*')
                    .group('schedules.id')
                    .having('COUNT(DISTINCT stations.name) = 2')
                    .distinct 
      trips = schedules.map do |schedule|
        stations = schedule.stations.order(:id)
        station_names = stations.map(&:name)

        # find the index of the departure and destination stations
        departure_index = station_names.index { |name| name =~ /#{departure_station}/i }
        destination_index = station_names.index { |name| name =~ /#{destination_station}/i }

        # this is used to exclude return trip , if the user is searching for a trip from pala to kottayam
        # it will exclude the trip from kottayam to pala (since database has both trips)

        if departure_index && destination_index && departure_index < destination_index
          departure_station_data = stations[departure_index]
          departure_time = Time.parse(departure_station_data.departure_time)

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

          trip_data[:stations] = trip_data[:stations][departure_index..destination_index] if exclude
          trip_data
        end
      end.compact

      # sort the trips by departure time of the departure station
      sorted_trips = trips.sort_by do |trip|
        time_str = trip[:stations].find { |station| station[:station] =~ /#{departure_station}/i }[:departureTime]
        Time.parse(time_str)
      end

      render json: sorted_trips, status: :ok
    else
      render json: { error: 'Departure and destination stations are required. ' }, status: :unprocessable_entity
    end
  end
end
