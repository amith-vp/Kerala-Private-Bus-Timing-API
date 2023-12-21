class CreateRoutes < ActiveRecord::Migration[7.1]
  def change
    create_table :routes do |t|
      t.references :bus_schedule, null: false, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
