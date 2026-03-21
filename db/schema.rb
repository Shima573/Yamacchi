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

ActiveRecord::Schema[7.2].define(version: 2026_03_16_071050) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "diagnoses", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.integer "total_score", null: false
    t.integer "recommended_physical_min", default: 0, null: false
    t.integer "recommended_physical_max", default: 0, null: false
    t.integer "recommended_technical_max", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_diagnoses_on_user_id"
  end

  create_table "mountains", force: :cascade do |t|
    t.string "name", null: false
    t.integer "elevation"
    t.string "prefecture"
    t.decimal "latitude", precision: 9, scale: 6
    t.decimal "longitude", precision: 9, scale: 6
    t.integer "raw_physical_grade"
    t.integer "raw_technical_grade", default: 0
    t.string "grade_source_prefecture"
    t.integer "normalized_physical_score"
    t.integer "normalized_technical_score"
    t.boolean "has_toilet", default: false, null: false
    t.text "access_detail"
    t.string "image_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_mountains_on_name"
    t.index ["normalized_physical_score"], name: "index_mountains_on_normalized_physical_score"
    t.index ["normalized_technical_score"], name: "index_mountains_on_normalized_technical_score"
    t.index ["prefecture"], name: "index_mountains_on_prefecture"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name", null: false
    t.string "avatar_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "diagnoses", "users"
end
