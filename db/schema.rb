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

ActiveRecord::Schema.define(version: 2018_06_17_124934) do

  create_table "drugstores", force: :cascade do |t|
    t.integer "hospital_id"
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hospital_id"], name: "index_drugstores_on_hospital_id"
  end

  create_table "hospital_transportation", force: :cascade do |t|
    t.integer "hospital_id"
    t.integer "transportation_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hospital_id"], name: "index_hospital_transportation_on_hospital_id"
    t.index ["transportation_id"], name: "index_hospital_transportation_on_transportation_id"
  end

  create_table "hospitals", force: :cascade do |t|
    t.string "name", null: false
    t.integer "expense", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "patients", force: :cascade do |t|
    t.string "name", null: false
    t.string "relationship", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "records", force: :cascade do |t|
    t.integer "hospital_id"
    t.integer "patient_id"
    t.date "date", null: false
    t.integer "cost", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hospital_id"], name: "index_records_on_hospital_id"
    t.index ["patient_id"], name: "index_records_on_patient_id"
  end

  create_table "transportation", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
