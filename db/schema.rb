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

ActiveRecord::Schema.define(version: 20170712061231) do

  create_table "cgames", force: :cascade do |t|
    t.string "name"
    t.integer "games_played"
    t.integer "player_id"
    t.boolean "home"
    t.string "pos"
    t.date "date"
    t.integer "goals"
    t.integer "assists"
    t.integer "points"
    t.integer "plus_minus"
    t.integer "pim"
    t.integer "ppg"
    t.integer "ppa"
    t.integer "ppp"
    t.integer "shg"
    t.integer "sha"
    t.integer "shp"
    t.integer "gwg"
    t.integer "otg"
    t.integer "shots"
    t.integer "toi"
    t.integer "shifts"
    t.integer "hits"
    t.integer "blocks"
    t.integer "mss"
    t.integer "gva"
    t.integer "tka"
    t.integer "fo"
    t.integer "fow"
    t.integer "fol"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "home_team_id"
    t.integer "away_team_id"
    t.index ["away_team_id"], name: "index_cgames_on_away_team_id"
    t.index ["home_team_id"], name: "index_cgames_on_home_team_id"
    t.index ["player_id"], name: "index_cgames_on_player_id"
  end

  create_table "igames", force: :cascade do |t|
    t.integer "player_id"
    t.boolean "home"
    t.string "pos"
    t.date "date"
    t.integer "goals"
    t.integer "assists"
    t.integer "points"
    t.integer "plus_minus"
    t.integer "pim"
    t.integer "ppg"
    t.integer "ppa"
    t.integer "ppp"
    t.integer "shg"
    t.integer "sha"
    t.integer "shp"
    t.integer "gwg"
    t.integer "otg"
    t.integer "shots"
    t.integer "toi"
    t.integer "shifts"
    t.integer "hits"
    t.integer "blocks"
    t.integer "mss"
    t.integer "gva"
    t.integer "tka"
    t.integer "fo"
    t.integer "fow"
    t.integer "fol"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "home_team_id"
    t.integer "away_team_id"
    t.index ["away_team_id"], name: "index_igames_on_away_team_id"
    t.index ["home_team_id"], name: "index_igames_on_home_team_id"
    t.index ["player_id"], name: "index_igames_on_player_id"
  end

  create_table "players", force: :cascade do |t|
    t.string "name"
    t.integer "team_id"
    t.boolean "lw"
    t.boolean "rw"
    t.boolean "c"
    t.boolean "d"
    t.boolean "g"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id"], name: "index_players_on_team_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.string "abbreviation"
    t.string "conference"
    t.string "division"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
