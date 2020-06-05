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

ActiveRecord::Schema.define(version: 20200604052620) do

  create_table "comments", force: :cascade do |t|
    t.integer "user_id"
    t.integer "user_image_id"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "user_image_id", "created_at"], name: "index_comments_on_user_id_and_user_image_id_and_created_at"
    t.index ["user_id"], name: "index_comments_on_user_id"
    t.index ["user_image_id"], name: "index_comments_on_user_image_id"
  end

  create_table "likes", force: :cascade do |t|
    t.integer "user_id"
    t.integer "user_image_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "user_image_id"], name: "index_likes_on_user_id_and_user_image_id", unique: true
    t.index ["user_id"], name: "index_likes_on_user_id"
    t.index ["user_image_id"], name: "index_likes_on_user_image_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.integer "visitor_id", null: false
    t.integer "visited_id", null: false
    t.integer "user_image_id"
    t.integer "comment_id"
    t.string "action", default: "", null: false
    t.boolean "checked", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["comment_id"], name: "index_notifications_on_comment_id"
    t.index ["user_image_id"], name: "index_notifications_on_user_image_id"
    t.index ["visited_id"], name: "index_notifications_on_visited_id"
    t.index ["visitor_id"], name: "index_notifications_on_visitor_id"
  end

  create_table "relationships", force: :cascade do |t|
    t.integer "follower_id"
    t.integer "followed_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["followed_id"], name: "index_relationships_on_followed_id"
    t.index ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true
    t.index ["follower_id"], name: "index_relationships_on_follower_id"
  end

  create_table "user_images", force: :cascade do |t|
    t.string "picture"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.index ["name"], name: "index_user_images_on_name"
    t.index ["user_id", "created_at"], name: "index_user_images_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_user_images_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "user_name"
    t.string "web_page"
    t.text "introduce"
    t.string "phone_number"
    t.integer "gender", default: 0
    t.boolean "admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
