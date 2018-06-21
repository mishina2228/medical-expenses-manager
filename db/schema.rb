# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_06_24_035639) do

  create_table "divisions", force: :cascade do |t|
    t.string "name", null: false
    t.string "type", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "type"], name: "index_divisions_on_name_and_type", unique: true
    t.index ["type"], name: "index_divisions_on_type"
  end

  create_table "hospital_transports", force: :cascade do |t|
    t.integer "hospital_id"
    t.integer "transport_id"
    t.integer "transport_cost", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hospital_id"], name: "index_hospital_transports_on_hospital_id"
    t.index ["transport_id"], name: "index_hospital_transports_on_transport_id"
  end

  create_table "people", force: :cascade do |t|
    t.string "name", null: false
    t.string "relationship", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_people_on_name", unique: true
  end

  create_table "records", force: :cascade do |t|
    t.integer "division_id"
    t.integer "person_id"
    t.date "date", null: false
    t.integer "cost", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["division_id"], name: "index_records_on_division_id"
    t.index ["person_id"], name: "index_records_on_person_id"
  end

end
