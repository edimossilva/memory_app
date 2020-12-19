# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_12_19_161206) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "memories", force: :cascade do |t|
    t.string "key"
    t.string "value"
    t.boolean "visibility"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id", null: false
    t.index ["user_id", "key"], name: "index_memories_on_user_id_and_key", unique: true
  end

  create_table "memory_tags", force: :cascade do |t|
    t.integer "memory_id", null: false
    t.integer "tag_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["memory_id", "tag_id"], name: "index_memory_tags_on_memory_id_and_tag_id", unique: true
    t.index ["memory_id"], name: "index_memory_tags_on_memory_id"
    t.index ["tag_id"], name: "index_memory_tags_on_tag_id"
  end

  create_table "shareable_list_memories", force: :cascade do |t|
    t.integer "shareable_list_id", null: false
    t.integer "memory_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["memory_id"], name: "index_shareable_list_memories_on_memory_id"
    t.index ["shareable_list_id"], name: "index_shareable_list_memories_on_shareable_list_id"
  end

  create_table "shareable_lists", force: :cascade do |t|
    t.string "name", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "public", default: false
    t.index ["user_id"], name: "index_shareable_lists_on_user_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id", "name"], name: "index_tags_on_user_id_and_name", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.integer "access_level"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["username"], name: "index_users_on_username", unique: true
  end

end
