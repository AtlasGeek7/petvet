class AddSpecialityToEmployees < ActiveRecord::Migration[6.0]
  def change
    add_column :employees, :speciality, :string
  end
end
