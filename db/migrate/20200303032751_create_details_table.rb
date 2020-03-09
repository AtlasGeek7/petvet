class CreateDetailsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :details do |t|
      t.string :full_name
      t.string :gender
      t.string :address
      t.string :dob
      t.string :phone_number
      t.integer :user_id
    end
  end
end
