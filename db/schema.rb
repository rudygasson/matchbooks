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

ActiveRecord::Schema[7.0].define(version: 2022_06_07_082834) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "books", force: :cascade do |t|
    t.string "isbn"
    t.string "title"
    t.string "author"
    t.text "description"
    t.integer "year"
    t.string "thumbnail"
    t.string "cover_image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "chatrooms", force: :cascade do |t|
    t.bigint "meeting_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["meeting_id"], name: "index_chatrooms_on_meeting_id"
  end

  create_table "copies", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "book_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_copies_on_book_id"
    t.index ["user_id"], name: "index_copies_on_user_id"
  end

  create_table "handovers", force: :cascade do |t|
    t.bigint "meeting_id", null: false
    t.bigint "copy_id", null: false
    t.bigint "receiver_id", null: false
    t.bigint "deliverer_id", null: false
    t.integer "status"
    t.datetime "confirmed", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["copy_id"], name: "index_handovers_on_copy_id"
    t.index ["deliverer_id"], name: "index_handovers_on_deliverer_id"
    t.index ["meeting_id"], name: "index_handovers_on_meeting_id"
    t.index ["receiver_id"], name: "index_handovers_on_receiver_id"
  end

  create_table "locations", force: :cascade do |t|
    t.integer "zipcode"
    t.string "address"
    t.string "name"
    t.string "district"
    t.decimal "latitude"
    t.decimal "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "meetings", force: :cascade do |t|
    t.date "date"
    t.time "time"
    t.bigint "location_id", null: false
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["location_id"], name: "index_meetings_on_location_id"
  end

  create_table "messages", force: :cascade do |t|
    t.string "content"
    t.bigint "chatroom_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chatroom_id"], name: "index_messages_on_chatroom_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "user_locations", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "location_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["location_id"], name: "index_user_locations_on_location_id"
    t.index ["user_id"], name: "index_user_locations_on_user_id"
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
    t.string "avatar"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "chatrooms", "meetings"
  add_foreign_key "copies", "books"
  add_foreign_key "copies", "users"
  add_foreign_key "handovers", "copies"
  add_foreign_key "handovers", "meetings"
  add_foreign_key "handovers", "users", column: "deliverer_id"
  add_foreign_key "handovers", "users", column: "receiver_id"
  add_foreign_key "meetings", "locations"
  add_foreign_key "messages", "chatrooms"
  add_foreign_key "messages", "users"
  add_foreign_key "user_locations", "locations"
  add_foreign_key "user_locations", "users"
end
