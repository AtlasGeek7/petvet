class CreateUserDetailsTable < ActiveRecord::Migration[5.2]
  create_table "user_details", force: :cascade do |t|
    t.string "full_name"
    t.string "gender"
    t.string "address"
    t.string "dob"
    t.string "phone_number"
    t.integer "user_id"
    t.integer "medicine_id"
  end
end
