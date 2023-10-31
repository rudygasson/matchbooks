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
    t.integer "meeting_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["meeting_id"], name: "index_chatrooms_on_meeting_id"
  end

  create_table "copies", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "book_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_copies_on_book_id"
    t.index ["user_id"], name: "index_copies_on_user_id"
  end

  create_table "handovers", force: :cascade do |t|
    t.integer "meeting_id", null: false
    t.integer "copy_id", null: false
    t.integer "receiver_id", null: false
    t.integer "deliverer_id", null: false
    t.integer "status", null: false
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
    t.integer "location_id", null: false
    t.integer "status", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["location_id"], name: "index_meetings_on_location_id"
  end

  create_table "messages", force: :cascade do |t|
    t.string "content"
    t.integer "chatroom_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chatroom_id"], name: "index_messages_on_chatroom_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "user_locations", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "location_id", null: false
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
