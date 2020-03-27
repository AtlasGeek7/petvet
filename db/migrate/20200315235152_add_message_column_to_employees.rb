class AddMessageColumnToEmployees < ActiveRecord::Migration[5.2]
  def change
    add_column :employees, :messages, :string
  end
end
