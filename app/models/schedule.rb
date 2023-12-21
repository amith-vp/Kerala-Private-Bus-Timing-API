# app/models/schedule.rb
class Schedule < ApplicationRecord
  belongs_to :route
  has_many :stations
end
