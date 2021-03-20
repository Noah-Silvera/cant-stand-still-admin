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

ActiveRecord::Schema.define(version: 2021_03_20_034853) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "riders", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "access_token_ciphertext"
    t.text "refresh_token_ciphertext"
    t.integer "user_id", null: false
    t.jsonb "athlete_json", null: false
    t.datetime "access_token_expires_at", default: "2021-03-20 03:51:59", null: false
    t.index ["user_id"], name: "index_riders_on_user_id", unique: true
  end

  create_table "rides", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id"
    t.integer "trip_id"
    t.jsonb "activity_json", null: false
    t.text "activity_id", null: false
    t.datetime "start_date", null: false
    t.index ["activity_id"], name: "index_rides_on_activity_id", unique: true
    t.index ["activity_json"], name: "index_rides_on_activity_json", using: :gin
    t.index ["start_date"], name: "index_rides_on_start_date"
    t.index ["trip_id"], name: "index_trip_id"
    t.index ["user_id"], name: "index_user_id"
  end

  create_table "trips", force: :cascade do |t|
    t.string "name"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id", null: false
    t.index ["name"], name: "index_trips_on_name"
    t.index ["user_id"], name: "index_trips_on_user_id"
  end

  add_foreign_key "rides", "riders", column: "user_id"
  add_foreign_key "rides", "trips"
  add_foreign_key "trips", "riders", column: "user_id"
end
