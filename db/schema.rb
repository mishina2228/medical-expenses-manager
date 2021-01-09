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

ActiveRecord::Schema.define(version: 2021_01_09_030428) do

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.integer "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "divisions", force: :cascade do |t|
    t.string "name", null: false
    t.string "type", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_divisions_on_deleted_at"
    t.index ["name", "type", "deleted_at"], name: "index_divisions_on_name_and_type_and_deleted_at", unique: true
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
    t.index ["transport_id", "hospital_id", "deleted_at"], name: "index_hospital_transports_on_3columns", unique: true
    t.index ["transport_id"], name: "index_hospital_transports_on_transport_id"
  end

  create_table "people", force: :cascade do |t|
    t.string "name", null: false
    t.string "relationship", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_people_on_deleted_at"
    t.index ["name", "relationship", "deleted_at"], name: "index_people_on_name_and_relationship_and_deleted_at", unique: true
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

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
end
