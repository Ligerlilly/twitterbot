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

ActiveRecord::Schema.define(version: 20150903173017) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "tweets", force: :cascade do |t|
    t.string   "tweet"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "search"
  end

  add_index "tweets", ["tweet"], name: "index_tweets_on_tweet", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.integer  "favourites_count"
    t.integer  "followers_count"
    t.string   "location"
    t.float    "geolat"
    t.float    "geolong"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "search"
  end

  add_index "users", ["name"], name: "index_users_on_name", unique: true, using: :btree

end
