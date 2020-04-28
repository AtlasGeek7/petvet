class CreatePets < ActiveRecord::Migration[6.0]
  def change
    create_table :pets do |t|
      t.string :name
      t.integer :age
      t.string :gender
      t.string :breed
      t.integer :user_id
      t.integer :medicine_id
      t.timestamps
    end
  end
end
