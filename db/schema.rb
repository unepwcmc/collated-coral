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

ActiveRecord::Schema.define(version: 20171102155207) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "projects", force: :cascade do |t|
    t.text "project_title"
    t.string "donors", null: false
    t.string "status", null: false
    t.string "start_date", null: false
    t.string "end_date", null: false
    t.string "country", null: false
    t.string "ocean_based_region", null: false
    t.string "beneficiaries"
    t.string "implementing_agency"
    t.string "total_project_cost"
    t.string "co_funding_entities"
    t.string "category"
    t.string "team_leader"
    t.text "further_information"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
