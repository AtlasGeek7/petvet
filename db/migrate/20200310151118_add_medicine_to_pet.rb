class AddMedicineToPet < ActiveRecord::Migration[5.2]
  def change
    add_column :pets, :medicine_id, :integer
  end
end
