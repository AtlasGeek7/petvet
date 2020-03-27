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

ActiveRecord::Schema.define(version: 2020_03_24_074134) do

  create_table "appointments", force: :cascade do |t|
    t.string "symptoms"
    t.string "reason"
    t.string "apt_date"
    t.string "full_name"
    t.integer "user_id"
    t.integer "employee_id"
    t.string "status"
    t.string "pet_name"
  end

  create_table "employees", force: :cascade do |t|
    t.string "name"
    t.integer "experience"
    t.string "speciality"
    t.string "email"
    t.string "password_digest"
    t.string "messages"
    t.integer "status"
    t.integer "cid"
  end

  create_table "medicines", force: :cascade do |t|
    t.string "rx_name"
    t.integer "pill_count"
    t.integer "pill_size"
    t.integer "pet_id"
    t.integer "employee_id"
  end

  create_table "pets", force: :cascade do |t|
    t.string "name"
    t.string "gender"
    t.string "age"
    t.string "breed"
    t.integer "user_id"
    t.integer "medicine_id"
    t.string "img"
  end

  create_table "reviews", force: :cascade do |t|
    t.string "title"
    t.string "content"
    t.integer "user_id"
    t.string "rating"
    t.string "date"
  end

  create_table "user_details", force: :cascade do |t|
    t.string "full_name"
    t.string "gender"
    t.string "address"
    t.string "dob"
    t.string "phone_number"
    t.integer "user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.string "messages"
    t.string "img"
    t.integer "cid"
  end

end
