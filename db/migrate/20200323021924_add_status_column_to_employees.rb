class AddStatusColumnToEmployees < ActiveRecord::Migration[5.2]
  def change
    add_column :employees, :status, :integer
  end
end
