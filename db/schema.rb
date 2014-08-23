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

ActiveRecord::Schema.define(version: 20140823162826) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bills", force: true do |t|
    t.decimal  "price",      precision: 6, scale: 2
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "flat_id"
    t.string   "item"
  end

  add_index "bills", ["flat_id"], name: "index_bills_on_flat_id", using: :btree

  create_table "events", force: true do |t|
    t.string   "title"
    t.datetime "start"
    t.datetime "end"
    t.boolean  "all_day",    default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "flat_id"
  end

  add_index "events", ["flat_id"], name: "index_events_on_flat_id", using: :btree

  create_table "flats", force: true do |t|
    t.string   "name"
    t.string   "address"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "purchases", force: true do |t|
    t.string   "name"
    t.boolean  "pending",    default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "flat_id"
  end

  add_index "purchases", ["flat_id"], name: "index_purchases_on_flat_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "flat_id"
  end

  add_index "users", ["flat_id"], name: "index_users_on_flat_id", using: :btree

end
