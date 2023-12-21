require 'json'

json_file = File.read(Rails.root.join('db', 'data.json'))
parsed_data = JSON.parse(json_file)
route =""

parsed_data['busSchedules'].each do |bus_schedule_data|
  bus_schedule = BusSchedule.create(vehicle_number: bus_schedule_data['Vehicle Number'])

  bus_schedule_data['route'].each do |route_name|
    route = bus_schedule.routes.create(name: route_name)
  end
  bus_schedule_data['schedule'].each do |schedule_data|
    schedule = route.schedules.create(trip: schedule_data['trip'])

    schedule_data['stations'].each do |station_data|
      schedule.stations.create(
        name: station_data['station'],
        arrival_time: station_data['arrivalTime'],
        departure_time: station_data['departureTime']
      )
    end
  end
end
