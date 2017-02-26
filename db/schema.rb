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

ActiveRecord::Schema.define(version: 20170226220410) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

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
    t.integer  "owner_id"
  end

  create_table "district_users", force: :cascade do |t|
    t.integer  "district_id"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["district_id"], name: "index_district_users_on_district_id", using: :btree
    t.index ["user_id"], name: "index_district_users_on_user_id", using: :btree
  end

  create_table "districts", force: :cascade do |t|
    t.string   "name"
    t.string   "division_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "offices", force: :cascade do |t|
    t.string   "name"
    t.string   "division_id"
    t.integer  "district_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["district_id"], name: "index_offices_on_district_id", using: :btree
  end

  create_table "rep_channels", force: :cascade do |t|
    t.string   "channel_type"
    t.string   "channel_id"
    t.integer  "rep_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["rep_id"], name: "index_rep_channels_on_rep_id", using: :btree
  end

  create_table "rep_phone_numbers", force: :cascade do |t|
    t.string   "number"
    t.integer  "rep_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["rep_id"], name: "index_rep_phone_numbers_on_rep_id", using: :btree
  end

  create_table "rep_urls", force: :cascade do |t|
    t.string   "url"
    t.integer  "rep_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["rep_id"], name: "index_rep_urls_on_rep_id", using: :btree
  end

  create_table "reps", force: :cascade do |t|
    t.string   "party"
    t.string   "name"
    t.string   "email"
    t.string   "img_url"
    t.integer  "address_id"
    t.integer  "office_id"
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
    t.uuid     "uuid",       default: -> { "uuid_generate_v4()" }
    t.index ["address_id"], name: "index_reps_on_address_id", using: :btree
    t.index ["office_id"], name: "index_reps_on_office_id", using: :btree
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
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.text     "password_digest"
    t.index ["address_id"], name: "index_users_on_address_id", using: :btree
  end

  add_foreign_key "campaign_tags", "campaigns"
  add_foreign_key "campaign_tags", "tags"
  add_foreign_key "campaign_users", "campaigns"
  add_foreign_key "campaign_users", "users"
  add_foreign_key "district_users", "districts"
  add_foreign_key "district_users", "users"
  add_foreign_key "offices", "districts"
  add_foreign_key "rep_channels", "reps"
  add_foreign_key "rep_phone_numbers", "reps"
  add_foreign_key "rep_urls", "reps"
  add_foreign_key "reps", "addresses"
  add_foreign_key "reps", "offices"
  add_foreign_key "users", "addresses"
end
