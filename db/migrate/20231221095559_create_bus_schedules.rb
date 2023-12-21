class CreateBusSchedules < ActiveRecord::Migration[7.1]
  def change
    create_table :bus_schedules do |t|
      t.string :vehicle_number

      t.timestamps
    end
  end
end
