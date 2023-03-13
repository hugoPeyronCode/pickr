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

ActiveRecord::Schema[7.0].define(version: 2023_03_13_113639) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "deck_items", force: :cascade do |t|
    t.bigint "item_id", null: false
    t.bigint "deck_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deck_id"], name: "index_deck_items_on_deck_id"
    t.index ["item_id"], name: "index_deck_items_on_item_id"
  end

  create_table "decks", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id", null: false
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "deck_type"
    t.string "address"
    t.integer "rating"
    t.integer "price_range"
    t.string "movie_genre"
    t.string "item_type"
    t.index ["user_id"], name: "index_decks_on_user_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.integer "rating"
    t.integer "price_range"
    t.string "item_type"
    t.string "photo_url"
    t.string "item_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "latitude"
    t.float "longitude"
    t.string "movie_title"
    t.string "movie_director"
    t.text "synopsis"
    t.string "movie_genre"
    t.string "opening_hours", array: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.string "phone_number"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "votes", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "deck_item_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "value"
    t.index ["deck_item_id"], name: "index_votes_on_deck_item_id"
    t.index ["user_id"], name: "index_votes_on_user_id"
  end

  add_foreign_key "deck_items", "decks"
  add_foreign_key "deck_items", "items"
  add_foreign_key "decks", "users"
  add_foreign_key "votes", "deck_items"
  add_foreign_key "votes", "users"
end
