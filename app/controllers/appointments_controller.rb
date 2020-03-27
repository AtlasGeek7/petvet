class AppointmentsContoller < ApplicationController

    get "/users/:id/home#book" do
        @current_user = User.find_by(email: session[:email])
        erb :"/users/#{@current_user.id}/home#book"
    end

    post "/appointment/book" do
        @current_user = User.find_by(email: session[:email])
        #if !(@current_user.appointments)
          @appointment = Appointment.new
          @appointment.symptoms = params[:symptoms]
          @appointment.apt_date = params[:date]
          @appointment.reason = params[:reason]
          @appointment.full_name = params[:full_name]
          @appointment.pet_name = params[:pet_name]
          @appointment.employee_id = params[:doctor].to_i
          @appointment.user_id = @current_user.id
          @appointment.status = "pending"
          @appointment.save
        #end
        redirect "/users/#{@current_user.id}/home#book"
    end

    get "/employee/:id/appointments/edit" do
        @current_employee = Employee.find_by(email: session[:email])
        @appointments = Appointment.all.select { |a| a.employee_id == @current_employee.id }
        @pending_apts = @appointments.select { |a| a.status == "pending"}
        redirect "/users/#{@current_user.id}/index#appt"
    end

    post "/appointment/update" do
        @current_employee = Employee.find_by(email: session[:email])
        @appointment = Appointment.all.find_by(id: params.first[0])
        @appointment.status = "confirmed"
        @appointment.save
        redirect "/users/#{@current_user.id}/index#appt"
    end

    post "/appointment/delete" do
        @current_employee = Employee.find_by(email: session[:email])
        @appointment = Appointment.all.find_by(id: params.first[0])
        @appointment.destroy
        redirect "/users/#{@current_user.id}/index#appt"
    end

end
