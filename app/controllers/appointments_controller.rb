class AppointmentsContoller < ApplicationController

    post "/appointment/book" do

      if session[:email]
          @current_user = User.find_by(email: session[:email])
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
          redirect "/users/#{@current_user.id}/home#book"
        else
          redirect "/users/home"
        end

    end

    post "/appointment/confirm" do

      if session[:email]
          @current_employee = Employee.find_by(email: session[:email])
          @appointment = Appointment.all.find_by(id: params.first[0])
          @appointment.status = "confirmed"
          @appointment.save
          redirect "/employee/#{@appointment.employee_id}/index#appt"
        else
          redirect "/employee/index"
        end

    end

    post "/appointment/delete" do

      if session[:email]
        @current_employee = Employee.find_by(email: session[:email])
        @appointment = Appointment.all.find_by(id: params.first[0])
        @appointment.destroy
        redirect "/employee/#{@appointment.employee_id}/index#appt"
      else
        redirect "/employee/index"
      end

    end

    post "/appointment/cancel" do

      if session[:email]
        @current_user = User.find_by(email: session[:email])
        @appointment = @current_user.appointments.all.first
        @appointment.destroy
        @appointment.save
        redirect "/users/#{@current_user.id}/home#book"
      else
        redirect "/users/home"
      end

    end


end
