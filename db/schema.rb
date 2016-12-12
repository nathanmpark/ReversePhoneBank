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

ActiveRecord::Schema.define(version: 20161212045027) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string   "line_1"
    t.string   "line_2"
    t.string   "city"
    t.string   "state"
    t.integer  "primary_zip"
    t.integer  "extended_zip"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "campaign_tags", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "campaign_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["campaign_id"], name: "index_campaign_tags_on_campaign_id", using: :btree
    t.index ["tag_id"], name: "index_campaign_tags_on_tag_id", using: :btree
  end

  create_table "campaign_users", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "campaign_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["campaign_id"], name: "index_campaign_users_on_campaign_id", using: :btree
    t.index ["user_id"], name: "index_campaign_users_on_user_id", using: :btree
  end

  create_table "campaigns", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "district_addresses", force: :cascade do |t|
    t.integer  "district_id"
    t.integer  "address_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["address_id"], name: "index_district_addresses_on_address_id", using: :btree
    t.index ["district_id"], name: "index_district_addresses_on_district_id", using: :btree
  end

  create_table "districts", force: :cascade do |t|
    t.integer  "campaign_id"
    t.string   "name"
    t.string   "state"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["campaign_id"], name: "index_districts_on_campaign_id", using: :btree
  end

  create_table "representatives", force: :cascade do |t|
    t.integer  "district_id"
    t.integer  "rep_type"
    t.string   "state"
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "party"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["district_id"], name: "index_representatives_on_district_id", using: :btree
  end

  create_table "tags", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "phone"
    t.integer  "address_id"
    t.integer  "user_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["address_id"], name: "index_users_on_address_id", using: :btree
  end

  add_foreign_key "campaign_tags", "campaigns"
  add_foreign_key "campaign_tags", "tags"
  add_foreign_key "campaign_users", "campaigns"
  add_foreign_key "campaign_users", "users"
  add_foreign_key "district_addresses", "addresses"
  add_foreign_key "district_addresses", "districts"
  add_foreign_key "districts", "campaigns"
  add_foreign_key "representatives", "districts"
  add_foreign_key "users", "addresses"
end
