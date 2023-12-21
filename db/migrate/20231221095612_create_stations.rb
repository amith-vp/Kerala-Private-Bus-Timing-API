class CreateStations < ActiveRecord::Migration[7.1]
  def change
    create_table :stations do |t|
      t.references :schedule, null: false, foreign_key: true
      t.string :name
      t.string :arrival_time
      t.string :departure_time

      t.timestamps
    end
  end
end
