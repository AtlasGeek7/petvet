class AddAddressColumn < ActiveRecord::Migration[5.2]
  def change
    add_column :profiles, :address, :text
  end
end
