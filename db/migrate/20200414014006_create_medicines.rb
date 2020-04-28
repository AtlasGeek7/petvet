class CreateMedicines < ActiveRecord::Migration[6.0]
  def change
    create_table :medicines do |t|
      t.string :rx_name
      t.integer :pill_count
      t.integer :pill_size
      t.integer :employee_id
      t.integer :pet_id

      t.timestamps
    end
  end
end
