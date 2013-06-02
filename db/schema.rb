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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130529212559) do

  create_table "meals", :force => true do |t|
    t.string   "name"
    t.datetime "time"
    t.integer  "calories"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "category"
    t.integer  "sheet_id"
  end

  add_index "meals", ["sheet_id"], :name => "index_meals_on_sheet_id"

  create_table "sheets", :force => true do |t|
    t.integer  "calories_target"
    t.datetime "date"
    t.integer  "week_num"
    t.integer  "day"
    t.integer  "water_glasses"
    t.integer  "sleep_hours"
    t.string   "notes"
    t.boolean  "goals_met"
    t.integer  "energy_level"
    t.integer  "user_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "sheets", ["date", "user_id"], :name => "index_sheets_on_date_and_user_id", :unique => true
  add_index "sheets", ["user_id"], :name => "index_sheets_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",           :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
