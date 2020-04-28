class CreateProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|
      t.string :full_name
      t.integer :age
      t.string :gender
      t.text :address
      t.integer :user_id

      t.timestamps
    end
  end
end
