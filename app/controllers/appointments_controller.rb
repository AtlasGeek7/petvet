class AppointmentsController < ApplicationController

    before_action :set_pets, only: [:new, :create]
    before_action :set_employees, only: [:new, :create]

  def index
    @current_user = current_user
    @current_employee = current_employee
  end
  def new
    @current_user = current_user
    @appointment = Appointment.new
    @dates = read_dates
  end

  def show
    @current_user = current_user
    @current_employee = current_employee
    @appointment = Appointment.find_by_id(params[:id])
  end

  def create
    @appointment = Appointment.create(appointment_params)
    if @appointment.valid?
      @appointment.save
      @dates = read_dates
      @dates.delete(@appointment.apt_date)
      write_dates(@dates)
      redirect_to appointment_path(@appointment)
    else
      render :new
    end
  end

  def update
    @appointment = Appointment.find_by_id(params[:id])
    @appointment.status = "confirmed"
    @appointment.save
    redirect_to appointment_path
  end

  def destroy
    @appointment = Appointment.find_by_id(params[:id])
    @appointment.destroy
    redirect_to appointments_path
  end

  private

  def set_pets
    @pets = current_user.pets.all
  end

  def set_employees
    @employees = Employee.all
  end

  def appointment_params
      params.require(:appointment).permit(:symptoms, :reason, :status, :apt_date, :full_name, :user_id, :employee_id, :pet_name)
  end

  def read_dates
    date_arr = []
    File.foreach("././public/dates.txt") { |line| date_arr << line }
    return date_arr
  end

  def write_dates(data)
    File.open("././public/dates.txt", "w") { |f|
      data.each { |d|
        f.write "#{d}"
      }
    }
  end

end
