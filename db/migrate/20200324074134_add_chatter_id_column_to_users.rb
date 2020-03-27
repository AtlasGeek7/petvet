class AddChatterIdColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :cid, :integer
  end
end
