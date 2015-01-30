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

ActiveRecord::Schema.define(version: 20150130005642) do

  create_table "bets", force: :cascade do |t|
    t.integer  "amount"
    t.string   "status",             default: "pending"
    t.integer  "game_id"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.float    "points"
    t.string   "team"
    t.integer  "initiating_user_id"
    t.integer  "receiving_user_id"
  end

  add_index "bets", ["game_id"], name: "index_bets_on_game_id"
  add_index "bets", ["initiating_user_id"], name: "index_bets_on_initiating_user_id"
  add_index "bets", ["receiving_user_id"], name: "index_bets_on_receiving_user_id"

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "bet_id"
    t.string   "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "comments", ["bet_id"], name: "index_comments_on_bet_id"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

  create_table "games", force: :cascade do |t|
    t.date     "date"
    t.string   "time"
    t.string   "home_team"
    t.string   "away_team"
    t.integer  "home_final_score", default: 0
    t.integer  "away_final_score", default: 0
    t.integer  "margin"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "images", force: :cascade do |t|
    t.string   "source"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "images", ["user_id"], name: "index_images_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "username"
    t.string   "name"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "password_digest"
    t.string   "remember_digest"
    t.boolean  "admin",           default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

end
