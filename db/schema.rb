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

ActiveRecord::Schema.define(version: 2018_08_05_025735) do

  create_table "divisions", force: :cascade do |t|
    t.string "name", null: false
    t.string "type", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_divisions_on_deleted_at"
    t.index ["name", "type"], name: "index_divisions_on_name_and_type", unique: true
    t.index ["type"], name: "index_divisions_on_type"
  end

  create_table "hospital_transports", force: :cascade do |t|
    t.integer "hospital_id", null: false
    t.integer "transport_id", null: false
    t.integer "transport_cost", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_hospital_transports_on_deleted_at"
    t.index ["hospital_id"], name: "index_hospital_transports_on_hospital_id"
    t.index ["transport_id"], name: "index_hospital_transports_on_transport_id"
  end

  create_table "people", force: :cascade do |t|
    t.string "name", null: false
    t.string "relationship", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_people_on_deleted_at"
    t.index ["name", "relationship"], name: "index_people_on_name_and_relationship", unique: true
  end

  create_table "records", force: :cascade do |t|
    t.integer "division_id", null: false
    t.integer "person_id", null: false
    t.date "date", null: false
    t.integer "cost", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_records_on_deleted_at"
    t.index ["division_id"], name: "index_records_on_division_id"
    t.index ["person_id"], name: "index_records_on_person_id"
  end

end
