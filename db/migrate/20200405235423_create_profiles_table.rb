class CreateProfilesTable < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles do |t|
      t.string :full_name
      t.integer :age
      t.string :gender
      t.string :address
      t.integer :user_id
      t.timestamps null: false
    end
  end
end
