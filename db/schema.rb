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

ActiveRecord::Schema.define(version: 20171022190810) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "drivers", force: :cascade do |t|
    t.string "name"
    t.string "last_name"
    t.string "email"
    t.string "document"
    t.string "photo"
    t.string "img_license"
    t.boolean "available"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "avatar_file_name"
    t.string "avatar_content_type"
    t.integer "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string "license_file_name"
    t.string "license_content_type"
    t.integer "license_file_size"
    t.datetime "license_updated_at"
    t.string "documentation_file_name"
    t.string "documentation_content_type"
    t.integer "documentation_file_size"
    t.datetime "documentation_updated_at"
    t.bigint "location_id"
    t.integer "location"
    t.index ["location"], name: "index_drivers_on_location"
    t.index ["location_id"], name: "index_drivers_on_location_id"
  end

  create_table "locations", force: :cascade do |t|
    t.float "lat"
    t.float "long"
    t.string "street"
    t.float "number"
    t.float "zipcode"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shipments", force: :cascade do |t|
    t.integer "price"
    t.date "date"
    t.string "payment"
    t.string "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "sender"
    t.integer "receiver"
    t.integer "origin"
    t.integer "destination"
    t.integer "driver"
    t.bigint "driver_id"
    t.bigint "sender_id"
    t.bigint "receiver_id"
    t.index ["destination"], name: "index_shipments_on_destination"
    t.index ["driver"], name: "index_shipments_on_driver"
    t.index ["driver_id"], name: "index_shipments_on_driver_id"
    t.index ["origin"], name: "index_shipments_on_origin"
    t.index ["receiver"], name: "index_shipments_on_receiver"
    t.index ["receiver_id"], name: "index_shipments_on_receiver_id"
    t.index ["sender"], name: "index_shipments_on_sender"
    t.index ["sender_id"], name: "index_shipments_on_sender_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "lastName"
    t.string "document"
    t.string "photo"
    t.string "avatar_file_name"
    t.string "avatar_content_type"
    t.integer "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.integer "invitee"
    t.integer "discounts"
    t.boolean "new_user"
    t.index ["invitee"], name: "index_users_on_invitee"
  end

  add_foreign_key "drivers", "locations"
  add_foreign_key "shipments", "drivers"
  add_foreign_key "shipments", "users", column: "receiver_id"
  add_foreign_key "shipments", "users", column: "sender_id"
end
