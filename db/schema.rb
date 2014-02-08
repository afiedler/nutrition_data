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

ActiveRecord::Schema.define(version: 20140208195014) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "pg_trgm"

  create_table "foods", force: true do |t|
    t.string   "ndb_number",          null: false
    t.string   "short_desc"
    t.decimal  "water"
    t.decimal  "kcal"
    t.decimal  "protein"
    t.decimal  "total_fat"
    t.decimal  "ash"
    t.decimal  "carbs"
    t.decimal  "total_fiber"
    t.decimal  "sugar"
    t.decimal  "calcium"
    t.decimal  "iron"
    t.decimal  "magnesium"
    t.decimal  "phosphorus"
    t.decimal  "sodium"
    t.decimal  "zinc"
    t.decimal  "copper"
    t.decimal  "manganese"
    t.decimal  "selenium"
    t.decimal  "vitamin_c"
    t.decimal  "thiamin"
    t.decimal  "riboflavin"
    t.decimal  "niacin"
    t.decimal  "panto_acid"
    t.decimal  "vitamin_b6"
    t.decimal  "total_folate"
    t.decimal  "folic_acid"
    t.decimal  "food_folate"
    t.decimal  "folate"
    t.decimal  "choline"
    t.decimal  "vitamin_b12"
    t.decimal  "vitamin_a_iu"
    t.decimal  "vitamin_a_rae"
    t.decimal  "retinol"
    t.decimal  "alpha_carot"
    t.decimal  "beta_carot"
    t.decimal  "lycopene"
    t.decimal  "lutein"
    t.decimal  "vitamin_e"
    t.decimal  "vitamin_d_mcg"
    t.decimal  "vitamin_d_iu"
    t.decimal  "vitamin_k"
    t.decimal  "saturated_fat"
    t.decimal  "monounsaturated_fat"
    t.decimal  "polyunsaturated_fat"
    t.decimal  "cholesterol"
    t.decimal  "weight_1_grams"
    t.string   "weight_1_desc"
    t.decimal  "weight_2_grams"
    t.string   "weight_2_desc"
    t.decimal  "refuse_percent"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "foods", ["ndb_number"], name: "index_foods_on_ndb_number", unique: true, using: :btree

end
