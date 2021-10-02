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

ActiveRecord::Schema.define(version: 2021_06_28_213352) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cleanups", force: :cascade do |t|
    t.bigint "hosted_at_id", null: false
    t.date "occurred_on", null: false
    t.integer "weight", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["hosted_at_id"], name: "index_cleanups_on_hosted_at_id"
  end

  create_table "cleanups_locations", force: :cascade do |t|
    t.bigint "cleanup_id", null: false
    t.bigint "location_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["cleanup_id"], name: "index_cleanups_locations_on_cleanup_id"
    t.index ["location_id"], name: "index_cleanups_locations_on_location_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "name", null: false
    t.jsonb "geojson", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "kind"
  end

  add_foreign_key "cleanups", "locations", column: "hosted_at_id"
  add_foreign_key "cleanups_locations", "cleanups"
  add_foreign_key "cleanups_locations", "locations"
end
