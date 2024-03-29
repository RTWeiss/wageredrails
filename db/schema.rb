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

ActiveRecord::Schema.define(version: 20150925185240) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bets", force: :cascade do |t|
    t.integer  "amount",                                 null: false
    t.string   "status",             default: "pending"
    t.integer  "game_id",                                null: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.float    "points",                                 null: false
    t.integer  "initiating_user_id",                     null: false
    t.integer  "receiving_user_id",                      null: false
    t.integer  "team_id"
  end

  add_index "bets", ["game_id"], name: "index_bets_on_game_id", using: :btree
  add_index "bets", ["initiating_user_id"], name: "index_bets_on_initiating_user_id", using: :btree
  add_index "bets", ["receiving_user_id"], name: "index_bets_on_receiving_user_id", using: :btree
  add_index "bets", ["team_id"], name: "index_bets_on_team_id", using: :btree

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.integer  "bet_id",     null: false
    t.string   "content",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "comments", ["bet_id"], name: "index_comments_on_bet_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "games", force: :cascade do |t|
    t.date     "date"
    t.string   "time"
    t.integer  "home_final_score", default: 0
    t.integer  "away_final_score", default: 0
    t.integer  "margin"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "home_team_id"
    t.integer  "away_team_id"
    t.integer  "season_id"
    t.integer  "league_id"
  end

  create_table "images", force: :cascade do |t|
    t.string   "source",     null: false
    t.integer  "user_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "images", ["user_id"], name: "index_images_on_user_id", unique: true, using: :btree

  create_table "leagues", force: :cascade do |t|
    t.string "name"
  end

  create_table "records", force: :cascade do |t|
    t.integer "year"
    t.integer "wins"
    t.integer "losses"
    t.integer "ties"
    t.integer "team_id"
    t.integer "league_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string  "name"
    t.string  "logo_url"
    t.integer "league_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                                  null: false
    t.string   "username",                               null: false
    t.string   "name",                                   null: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.boolean  "admin",                  default: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "failed_attempts",        default: 0,     null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree

  add_foreign_key "games", "leagues"
  add_foreign_key "games", "records", column: "season_id"
  add_foreign_key "games", "teams", column: "away_team_id"
  add_foreign_key "games", "teams", column: "home_team_id"
  add_foreign_key "records", "leagues"
  add_foreign_key "records", "teams"
end
