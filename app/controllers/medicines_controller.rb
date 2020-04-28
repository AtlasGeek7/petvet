class MedicinesController < ApplicationController

  before_action :require_login

  def index
    if params[:pet_id]
      @medicines = Pet.find(params[:pet_id]).medicines
    end
    if params[:employee_id]
      @medicines = Employee.find(params[:employee_id]).medicines
    end
  end

  def new
    @medicine = Medicine.new(employee_id: params[:employee_id])
    @pets = Pet.all
  end

  def create
    @medicine = Medicine.create(medicine_params)
    if @medicine.valid?
      @medicine.save
      #redirect_to medicine_path(@medicine)
      redirect_to employee_medicines_path(current_employee)
    else
      redirect_to new_employee_medicine_path(current_employee), :flash => { :error => @medicine.errors.full_messages }
    end
  end

  def show
    @medicine = Medicine.find_by(params[:id])
  end

  private
    # requiring a valid session before exposing any resources.
    def require_login
      return head(:forbidden) unless current_user || current_employee
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def medicine_params
        params.require(:medicine).permit(:rx_name, :pill_count, :pill_size, :employee_id, :pet_id)
    end

end
