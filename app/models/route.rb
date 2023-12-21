 # app/models/route.rb
 class Route < ApplicationRecord
  belongs_to :bus_schedule
  has_many :schedules
end
