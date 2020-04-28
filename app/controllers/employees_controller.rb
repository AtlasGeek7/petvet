class EmployeesController < ApplicationController
  def index
    redirect_to employee_path(current_employee)
  end

  def show
    @employee = Employee.find_by_id(params[:id])
  end
end
