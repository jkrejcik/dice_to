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

ActiveRecord::Schema[7.0].define(version: 2023_03_29_215719) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "custom_results", force: :cascade do |t|
    t.string "question"
    t.string "answer"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_custom_results_on_user_id"
  end

  create_table "movie_results", force: :cascade do |t|
    t.integer "rating"
    t.bigint "movie_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "time_taken"
    t.boolean "accepted"
    t.index ["movie_id"], name: "index_movie_results_on_movie_id"
    t.index ["user_id"], name: "index_movie_results_on_user_id"
  end

  create_table "movies", force: :cascade do |t|
    t.string "title"
    t.string "director"
    t.string "genre"
    t.integer "year"
    t.text "overview"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "vote_average"
  end

  create_table "options", force: :cascade do |t|
    t.bigint "custom_result_id", null: false
    t.string "input"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["custom_result_id"], name: "index_options_on_custom_result_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string "question"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "restaurant_results", force: :cascade do |t|
    t.bigint "restaurant_id", null: false
    t.bigint "user_id", null: false
    t.string "time_taken"
    t.integer "rating"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "accepted"
    t.index ["restaurant_id"], name: "index_restaurant_results_on_restaurant_id"
    t.index ["user_id"], name: "index_restaurant_results_on_user_id"
  end

  create_table "restaurants", force: :cascade do |t|
    t.string "name"
    t.string "city"
    t.float "rating"
    t.string "address"
    t.string "cuisine"
    t.string "phone"
    t.integer "price"
    t.string "image_1"
    t.string "image_2"
    t.string "image_3"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "place_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "rating"
    t.bigint "movie_result_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["movie_result_id"], name: "index_reviews_on_movie_result_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "movie_results", "movies"
  add_foreign_key "movie_results", "users"
  add_foreign_key "options", "custom_results"
  add_foreign_key "restaurant_results", "restaurants"
  add_foreign_key "restaurant_results", "users"
  add_foreign_key "reviews", "movie_results"
end
