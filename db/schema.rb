# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2023_12_21_095612) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bus_schedules", force: :cascade do |t|
    t.string "vehicle_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "routes", force: :cascade do |t|
    t.bigint "bus_schedule_id", null: false
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bus_schedule_id"], name: "index_routes_on_bus_schedule_id"
  end

  create_table "schedules", force: :cascade do |t|
    t.bigint "route_id", null: false
    t.integer "trip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["route_id"], name: "index_schedules_on_route_id"
  end

  create_table "stations", force: :cascade do |t|
    t.bigint "schedule_id", null: false
    t.string "name"
    t.string "arrival_time"
    t.string "departure_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["schedule_id"], name: "index_stations_on_schedule_id"
  end

  add_foreign_key "routes", "bus_schedules"
  add_foreign_key "schedules", "routes"
  add_foreign_key "stations", "schedules"
end
