# app/models/bus_schedule.rb
class BusSchedule < ApplicationRecord
    has_many :routes
end
  
 