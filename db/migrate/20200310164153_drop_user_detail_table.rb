class DropUserDetailTable < ActiveRecord::Migration[5.2]
  def change
    drop_table :user_detail
  end
end
