# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_08_20_191335) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "riders", force: :cascade do |t|
    t.string "email", null: false
  end

  create_table "rides", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "rider_id"
    t.integer "trip_id"
    t.index ["rider_id"], name: "index_rider_id"
    t.index ["trip_id"], name: "index_trip_id"
  end

  create_table "trips", force: :cascade do |t|
    t.string "name"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "rider_id", null: false
    t.index ["name"], name: "index_trips_on_name"
    t.index ["rider_id"], name: "index_trips_on_rider_id"
  end

  add_foreign_key "trips", "riders"
end
