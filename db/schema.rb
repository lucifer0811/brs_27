# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160707062815) do

  create_table "activities", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "target_id"
    t.integer  "activity_type"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "book_statuses", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "book_id"
    t.integer  "reading_status"
    t.boolean  "is_favorite"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "books", force: :cascade do |t|
    t.string   "title"
    t.string   "author"
    t.datetime "publish_date"
    t.integer  "number_of_page"
    t.integer  "category_id"
    t.string   "rate"
    t.integer  "number_of_rate"
    t.string   "cover"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string   "category_name"
    t.string   "descriptions"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "review_id"
    t.integer  "user_id"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "likes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "activity_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "requests", force: :cascade do |t|
    t.integer  "user_id"
    t.boolean  "is_approved"
    t.string   "book_name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "reviews", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "book_id"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_relationships", force: :cascade do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.boolean  "is_admin"
    t.string   "gravatar"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

end
