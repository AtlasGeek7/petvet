class AddChatterIdColumnToEmployees < ActiveRecord::Migration[5.2]
  def change
    add_column :employees, :cid, :integer
  end
end
