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

ActiveRecord::Schema.define(version: 20180105041908) do

  create_table "attraction_events", force: :cascade do |t|
    t.integer "event_id"
    t.integer "attraction_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["attraction_id"], name: "index_attraction_events_on_attraction_id"
    t.index ["event_id"], name: "index_attraction_events_on_event_id"
  end

  create_table "attractions", force: :cascade do |t|
    t.string "name"
    t.string "twitter"
    t.string "facebook"
    t.string "instagram"
    t.string "youtube"
    t.string "tm_attraction_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string "subgenre_name"
    t.string "subgenre_tm_id"
    t.string "genre_name"
    t.string "genre_tm_id"
    t.string "classification_name"
    t.string "classification_tm_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "category_events", force: :cascade do |t|
    t.integer "category_id"
    t.integer "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_category_events_on_category_id"
    t.index ["event_id"], name: "index_category_events_on_event_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "name"
    t.datetime "sale_start_date"
    t.datetime "sale_end_date"
    t.datetime "start_date"
    t.float "price_min"
    t.float "price_max"
    t.string "image_1"
    t.string "tm_url"
    t.string "category"
    t.string "genre"
    t.string "subgenre"
    t.string "tm_event_id"
    t.integer "venue_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["venue_id"], name: "index_events_on_venue_id"
  end

  create_table "relationships", force: :cascade do |t|
    t.integer "user_id"
    t.integer "friend_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["friend_id"], name: "index_relationships_on_friend_id"
    t.index ["user_id", "friend_id"], name: "index_relationships_on_user_id_and_friend_id", unique: true
    t.index ["user_id"], name: "index_relationships_on_user_id"
  end

  create_table "tickets", force: :cascade do |t|
    t.integer "user_id"
    t.integer "event_id"
    t.float "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_tickets_on_event_id"
    t.index ["user_id"], name: "index_tickets_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.string "first_name"
    t.string "last_name"
    t.datetime "birth_date"
    t.string "email"
    t.string "address"
    t.string "address2"
    t.string "city"
    t.string "state"
    t.integer "postal_code"
    t.bigint "cc_number"
    t.datetime "cc_expiration"
    t.string "cc_name"
    t.integer "cc_security_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "venues", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "city"
    t.string "state"
    t.string "postal_code"
    t.string "general_info"
    t.string "parking_details"
    t.string "tm_venue_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
