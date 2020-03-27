class RemoveMedicineIdFromUserDetails < ActiveRecord::Migration[5.2]
  def change
    remove_column :user_details, :medicine_id
  end
end
