# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150504164215) do

  create_table "attachments", force: :cascade do |t|
    t.integer  "space_id",   null: false
    t.string   "file_name",  null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "attachments", ["space_id"], name: "index_attachments_on_space_id"

  create_table "bookings", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.integer  "space_id",   null: false
    t.integer  "vehicle_id", null: false
    t.datetime "date_from",  null: false
    t.datetime "date_until", null: false
    t.string   "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "bookings", ["space_id"], name: "index_bookings_on_space_id"
  add_index "bookings", ["user_id"], name: "index_bookings_on_user_id"
  add_index "bookings", ["vehicle_id"], name: "index_bookings_on_vehicle_id"

  create_table "favorites", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.integer  "space_id",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "favorites", ["space_id"], name: "index_favorites_on_space_id"
  add_index "favorites", ["user_id"], name: "index_favorites_on_user_id"

  create_table "reviews", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.integer  "space_id",   null: false
    t.integer  "evaluation", null: false
    t.text     "comment",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "reviews", ["space_id"], name: "index_reviews_on_space_id"
  add_index "reviews", ["user_id"], name: "index_reviews_on_user_id"

  create_table "spaces", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "title",                         null: false
    t.integer  "available_spaces",              null: false
    t.text     "description",                   null: false
    t.string   "country",                       null: false
    t.string   "city",                          null: false
    t.string   "address",                       null: false
    t.string   "post_code",                     null: false
    t.float    "price_hour",                    null: false
    t.float    "price_week"
    t.float    "price_month"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "date_from",                     null: false
    t.datetime "date_until",                    null: false
    t.boolean  "available_weekend"
    t.integer  "reviews_count",     default: 0, null: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "spaces", ["reviews_count"], name: "index_spaces_on_reviews_count"
  add_index "spaces", ["user_id"], name: "index_spaces_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "first_name",                       default: "", null: false
    t.string   "last_name",                        default: "", null: false
    t.string   "username",                         default: "", null: false
    t.string   "email",                            default: "", null: false
    t.string   "avatar"
    t.integer  "phone_number",           limit: 8
    t.date     "date_of_birth"
    t.string   "encrypted_password",               default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                    default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "vehicles", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "plate",      null: false
    t.string   "make"
    t.string   "model"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "vehicles", ["user_id"], name: "index_vehicles_on_user_id"

end
