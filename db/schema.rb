# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_04_27_230039) do

  create_table "appointments", force: :cascade do |t|
    t.string "symptoms"
    t.string "reason"
    t.string "status"
    t.string "apt_date"
    t.string "full_name"
    t.integer "user_id"
    t.integer "employee_id"
    t.string "pet_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "employees", force: :cascade do |t|
    t.string "username"
    t.text "email"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.string "experience"
    t.string "speciality"
  end

  create_table "medicines", force: :cascade do |t|
    t.string "rx_name"
    t.integer "pill_count"
    t.integer "pill_size"
    t.integer "employee_id"
    t.integer "pet_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "pets", force: :cascade do |t|
    t.string "name"
    t.integer "age"
    t.string "gender"
    t.string "breed"
    t.integer "user_id"
    t.integer "medicine_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "profiles", force: :cascade do |t|
    t.string "full_name"
    t.integer "age"
    t.string "gender"
    t.text "address"
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.text "email"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
