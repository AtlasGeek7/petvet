class AddPetNameToAppointment < ActiveRecord::Migration[5.2]
  def change
    add_column :appointments, :pet_name, :string
  end
end
