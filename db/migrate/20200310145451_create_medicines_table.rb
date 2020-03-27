class CreateMedicinesTable < ActiveRecord::Migration[5.2]
  def change
    create_table :medicines do |t|
      t.string :rx_name
      t.integer :pill_count
      t.integer :pill_size
      t.integer :pet_id
      t.integer :employee_id
    end
  end
end
