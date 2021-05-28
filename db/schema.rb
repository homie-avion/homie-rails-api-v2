# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_05_26_073530) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "chats", force: :cascade do |t|
    t.boolean "success", default: false
    t.bigint "user_id"
    t.bigint "partner_id"
    t.bigint "property_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["partner_id"], name: "index_chats_on_partner_id"
    t.index ["property_id"], name: "index_chats_on_property_id"
    t.index ["user_id"], name: "index_chats_on_user_id"
  end

  create_table "cities", force: :cascade do |t|
    t.string "name"
    t.decimal "latitude", precision: 10, scale: 6
    t.decimal "longitude", precision: 10, scale: 6
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "city_preferences", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "city_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["city_id"], name: "index_city_preferences_on_city_id"
    t.index ["user_id", "city_id"], name: "index_city_preferences_on_user_id_and_city_id", unique: true
    t.index ["user_id"], name: "index_city_preferences_on_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.text "content"
    t.bigint "chat_id"
    t.bigint "user_id_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["chat_id"], name: "index_messages_on_chat_id"
    t.index ["user_id_id"], name: "index_messages_on_user_id_id"
  end

  create_table "properties", force: :cascade do |t|
    t.string "name"
    t.integer "rent_price"
    t.integer "tenant_count"
    t.integer "property_count"
    t.string "bldg_no"
    t.string "street"
    t.string "barangay"
    t.text "complete_address"
    t.text "picture_urls", default: [], array: true
    t.decimal "latitude", precision: 10, scale: 6
    t.decimal "longitude", precision: 10, scale: 6
    t.integer "like_count", default: 0
    t.integer "watch_list_count", default: 0
    t.integer "homie_value", default: 5
    t.integer "cost_living_index", default: 5
    t.integer "flood_index", default: 5
    t.boolean "posted", default: false
    t.bigint "user_id"
    t.bigint "city_id"
    t.bigint "rent_id"
    t.bigint "stay_period_id"
    t.bigint "property_type_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["city_id"], name: "index_properties_on_city_id"
    t.index ["property_type_id"], name: "index_properties_on_property_type_id"
    t.index ["rent_id"], name: "index_properties_on_rent_id"
    t.index ["stay_period_id"], name: "index_properties_on_stay_period_id"
    t.index ["user_id"], name: "index_properties_on_user_id"
  end

  create_table "property_type_preferences", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "property_type_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["property_type_id"], name: "index_property_type_preferences_on_property_type_id"
    t.index ["user_id", "property_type_id"], name: "index_property_type_preferences_on_user_id_and_property_type_id", unique: true
    t.index ["user_id"], name: "index_property_type_preferences_on_user_id"
  end

  create_table "property_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "rent_preferences", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "rent_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["rent_id"], name: "index_rent_preferences_on_rent_id"
    t.index ["user_id", "rent_id"], name: "index_rent_preferences_on_user_id_and_rent_id", unique: true
    t.index ["user_id"], name: "index_rent_preferences_on_user_id"
  end

  create_table "rents", force: :cascade do |t|
    t.string "name"
    t.string "filter_expression"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "stay_period_preferences", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "stay_period_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["stay_period_id"], name: "index_stay_period_preferences_on_stay_period_id"
    t.index ["user_id", "stay_period_id"], name: "index_stay_period_preferences_on_user_id_and_stay_period_id", unique: true
    t.index ["user_id"], name: "index_stay_period_preferences_on_user_id"
  end

  create_table "stay_periods", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.bigint "property_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["property_id"], name: "index_transactions_on_property_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.string "email"
    t.boolean "approved", default: true
    t.bigint "role_id"
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["role_id"], name: "index_users_on_role_id"
  end

  add_foreign_key "chats", "users"
  add_foreign_key "chats", "users", column: "partner_id"
  add_foreign_key "city_preferences", "cities"
  add_foreign_key "city_preferences", "users"
  add_foreign_key "property_type_preferences", "property_types"
  add_foreign_key "property_type_preferences", "users"
  add_foreign_key "rent_preferences", "rents"
  add_foreign_key "rent_preferences", "users"
  add_foreign_key "stay_period_preferences", "stay_periods"
  add_foreign_key "stay_period_preferences", "users"
end
