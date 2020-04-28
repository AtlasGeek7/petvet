class AddExperienceToEmployees < ActiveRecord::Migration[6.0]
  def change
    add_column :employees, :experience, :string
  end
end
