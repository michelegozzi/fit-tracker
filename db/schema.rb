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

ActiveRecord::Schema.define(:version => 20130710204533) do

  create_table "activities", :force => true do |t|
    t.string   "name"
    t.datetime "time"
    t.integer  "duration"
    t.integer  "intensity"
    t.integer  "sheet_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "category"
  end

  add_index "activities", ["sheet_id"], :name => "index_activities_on_sheet_id"

  create_table "foods", :force => true do |t|
    t.integer  "food_code",            :limit => 10
    t.string   "display_name"
    t.decimal  "portion_default",                    :precision => 10, :scale => 5
    t.decimal  "portion_amount",                     :precision => 10, :scale => 5
    t.string   "portion_display_name"
    t.decimal  "factor",                             :precision => 10, :scale => 5
    t.decimal  "increment_factor",                   :precision => 10, :scale => 5
    t.decimal  "multiplier_factor",                  :precision => 10, :scale => 5
    t.decimal  "grains",                             :precision => 10, :scale => 5
    t.decimal  "whole_grains",                       :precision => 10, :scale => 5
    t.decimal  "vegetables",                         :precision => 10, :scale => 5
    t.decimal  "orange_vegetables",                  :precision => 10, :scale => 5
    t.decimal  "drkgreen_vegetables",                :precision => 10, :scale => 5
    t.decimal  "starchy_vegetables",                 :precision => 10, :scale => 5
    t.decimal  "other_vegetables",                   :precision => 10, :scale => 5
    t.decimal  "fruits",                             :precision => 10, :scale => 5
    t.decimal  "milk",                               :precision => 10, :scale => 5
    t.decimal  "meats",                              :precision => 10, :scale => 5
    t.decimal  "soy",                                :precision => 10, :scale => 5
    t.decimal  "drybeans_peas",                      :precision => 10, :scale => 5
    t.decimal  "oils",                               :precision => 10, :scale => 5
    t.decimal  "solid_fats",                         :precision => 10, :scale => 5
    t.decimal  "added_sugars",                       :precision => 10, :scale => 5
    t.decimal  "alcohol",                            :precision => 10, :scale => 5
    t.decimal  "calories",                           :precision => 10, :scale => 5
    t.decimal  "saturated_fats",                     :precision => 10, :scale => 5
    t.datetime "created_at",                                                        :null => false
    t.datetime "updated_at",                                                        :null => false
  end

  add_index "foods", ["display_name"], :name => "index_foods_on_display_name"

  create_table "meals", :force => true do |t|
    t.string   "name"
    t.datetime "time"
    t.integer  "calories"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "category"
    t.integer  "sheet_id"
  end

  add_index "meals", ["name"], :name => "index_meals_on_name"
  add_index "meals", ["sheet_id"], :name => "index_meals_on_sheet_id"

  create_table "sheets", :force => true do |t|
    t.integer  "calorie_target"
    t.datetime "date"
    t.integer  "week_num"
    t.integer  "day"
    t.integer  "water_glasses"
    t.integer  "sleep_hours"
    t.string   "notes"
    t.boolean  "goals_met"
    t.integer  "energy_level"
    t.integer  "user_id"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
    t.integer  "total_calories_consumed"
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
