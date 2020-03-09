class CreateAptTable < ActiveRecord::Migration[5.2]
  def change
    create_table :appointments do |t|
      t.string :symptoms
      t.string :reason
      t.string :apt_date
      t.string :full_name
      t.integer :user_id
      t.integer :employee_id
    end
  end
end
