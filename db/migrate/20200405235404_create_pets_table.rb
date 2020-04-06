class CreatePetsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :pets do |t|
      t.string :name
      t.string :gender
      t.integer :age
      t.string :breed
      t.integer :user_id
      t.timestamps null: false
    end
  end
end
