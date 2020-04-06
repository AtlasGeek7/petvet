class RemoveAddressColumn < ActiveRecord::Migration[5.2]
  def change
    remove_column :profiles, :address
  end
end
