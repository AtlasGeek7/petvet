class CreateAppointments < ActiveRecord::Migration[6.0]
  def change
    create_table :appointments do |t|
      t.string :symptoms
      t.string :reason
      t.string :status
      t.string :apt_date
      t.string :full_name
      t.integer :user_id
      t.integer :employee_id
      t.string :pet_name

      t.timestamps
    end
  end
end
