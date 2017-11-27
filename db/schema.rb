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

ActiveRecord::Schema.define(version: 20171123135920) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "countries", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "donors", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ecosystems", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ocean_regions", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "project_countries", force: :cascade do |t|
    t.bigint "project_id"
    t.bigint "country_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id"], name: "index_project_countries_on_country_id"
    t.index ["project_id"], name: "index_project_countries_on_project_id"
  end

  create_table "project_donors", force: :cascade do |t|
    t.bigint "project_id"
    t.bigint "donor_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["donor_id"], name: "index_project_donors_on_donor_id"
    t.index ["project_id"], name: "index_project_donors_on_project_id"
  end

  create_table "project_ecosystems", force: :cascade do |t|
    t.bigint "project_id"
    t.bigint "ecosystem_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ecosystem_id"], name: "index_project_ecosystems_on_ecosystem_id"
    t.index ["project_id"], name: "index_project_ecosystems_on_project_id"
  end

  create_table "project_ocean_regions", force: :cascade do |t|
    t.bigint "project_id"
    t.bigint "ocean_region_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ocean_region_id"], name: "index_project_ocean_regions_on_ocean_region_id"
    t.index ["project_id"], name: "index_project_ocean_regions_on_project_id"
  end

  create_table "projects", force: :cascade do |t|
    t.text "project_title"
    t.string "status", null: false
    t.integer "start_date", null: false
    t.integer "end_date", null: false
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
