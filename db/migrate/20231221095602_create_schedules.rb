class CreateSchedules < ActiveRecord::Migration[7.1]
  def change
    create_table :schedules do |t|
      t.references :route, null: false, foreign_key: true
      t.integer :trip

      t.timestamps
    end
  end
end
