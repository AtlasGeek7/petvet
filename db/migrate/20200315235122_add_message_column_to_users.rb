class AddMessageColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :messages, :string
  end
end
