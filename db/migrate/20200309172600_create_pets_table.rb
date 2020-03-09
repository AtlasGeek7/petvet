class CreatePetsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :pets do |t|
      t.string :name
      t.string :gender
      t.string :age
      t.string :breed
      t.integer :user_id
    end
  end
end
