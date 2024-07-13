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

ActiveRecord::Schema[7.0].define(version: 2024_07_11_123710) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "actors", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_actors_on_name", unique: true
  end

  create_table "locations", force: :cascade do |t|
    t.string "name"
    t.string "country"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "country"], name: "index_locations_on_name_and_country", unique: true
  end

  create_table "movie_actor_locations", force: :cascade do |t|
    t.bigint "movie_id", null: false
    t.bigint "actor_id", null: false
    t.bigint "location_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["actor_id"], name: "index_movie_actor_locations_on_actor_id"
    t.index ["location_id"], name: "index_movie_actor_locations_on_location_id"
    t.index ["movie_id", "actor_id", "location_id"], name: "idx_movie_actor_locations_unique", unique: true
    t.index ["movie_id"], name: "index_movie_actor_locations_on_movie_id"
  end

  create_table "movies", force: :cascade do |t|
    t.string "name", null: false
    t.text "description", null: false
    t.integer "year", null: false
    t.string "director", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reviews", force: :cascade do |t|
    t.bigint "movie_id", null: false
    t.string "user", default: "", null: false
    t.integer "stars", default: 0, null: false
    t.text "review", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["movie_id", "user"], name: "index_reviews_on_movie_id_and_user", unique: true
    t.index ["movie_id"], name: "index_reviews_on_movie_id"
  end

  add_foreign_key "movie_actor_locations", "actors"
  add_foreign_key "movie_actor_locations", "locations"
  add_foreign_key "movie_actor_locations", "movies"
  add_foreign_key "reviews", "movies"
end
