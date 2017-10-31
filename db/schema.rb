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

ActiveRecord::Schema.define(version: 20171031220506) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "doctors", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "specialty"
    t.string "gender"
    t.string "street"
    t.string "city"
    t.string "state"
    t.string "zipcode", null: false
    t.string "phone_number"
    t.string "website"
    t.string "email_address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "doctors_insurances", id: false, force: :cascade do |t|
    t.bigint "insurance_id", null: false
    t.bigint "doctor_id", null: false
  end

  create_table "doctors_users", id: false, force: :cascade do |t|
    t.bigint "doctor_id", null: false
    t.bigint "user_id", null: false
  end

  create_table "insurances", force: :cascade do |t|
    t.string "insurance_uid"
    t.string "insurance_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "recommendations", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "doctor_id", null: false
    t.text "review"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["doctor_id"], name: "index_recommendations_on_doctor_id"
    t.index ["user_id"], name: "index_recommendations_on_user_id"
  end

  create_table "recommendations_tags", id: false, force: :cascade do |t|
    t.bigint "recommendation_id", null: false
    t.bigint "tag_id", null: false
  end

  create_table "tags", force: :cascade do |t|
    t.string "description", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "default", null: false
    t.string "category", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "username", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
