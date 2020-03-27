class EmployeeController < ApplicationController

    get "/employee_logout" do
        employee_logout!
    end

    get "/employee/index" do
      erb :"/employee/index"
    end

    post "/employee/index" do

      employees = Employee.all.map { |e| e.email}
      if employees.include?(params[:email]) && params[:cmd] == "signup"
          erb :"/employee/index", locals: {error: "&bull; E-mail already in use!"}
      elsif !(employees.include?(params[:email])) && params[:cmd] == "signup"
          @employee = Employee.new(email: params[:email], password: params[:password], name: params[:name], speciality: params[:specialty], experience: params[:experience])
          @employee.status = -1
          @employee.messages = "Welcome to Live Chat!~"
          @employee.cid = 0
          @employee.save
          redirect "/employee/index"
      elsif employees.include?(params[:email]) && params[:cmd] == "login"
        login_employee(params[:email], params[:password])
        @current_employee = Employee.find_by(email: session[:email])
        redirect "/employee/#{@current_employee.id}/index"
      elsif !(employees.include?(params[:email])) && params[:cmd] == "login"

        erb :"/employee/index", locals: {error: "&bull; Wrong credentials!"}
      end

    end

    get "/employee/:id/index" do
        @current_employee = Employee.find_by(email: session[:email])
        erb :"/employee/index"
    end

    get "/appointment/select/:id" do
        @detail = Appointment.all.find_by(id: params[:id])
        json @detail
    end

    get "/employee/:id/chat" do
      @current_employee = Employee.find_by(email: session[:email])
      #@current_user.messages = "[Mar-03-06 02:32:54 (CT)] Kat Nip says: testing...~"
      @messages = @current_employee.messages.split('~')
      #@current_user.save
      erb :"/employee/chat"
    end

    get "/employee/status" do
      erb :"/employee/status"
    end

    get "/employee/chat_history" do
      @current_employee = Employee.find_by(email: session[:email])
      if @current_employee
        @messages = @current_employee.messages.split('~')
        erb :"/employee/chat_history"
      end

    end



    post "/employee/update_status" do
      @current_employee = Employee.find_by(email: session[:email])
      cmd = params[:cmd]
      @current_employee.status = (cmd == '1') ? 1  : 0
      if cmd == '1' && @current_employee.cid != 0
        uid = @current_employee.cid
        @chat_user = User.find_by(id: uid)
        @chat_user.cid = 0
        @current_employee.messages = "Welcome to Live Chat!~"
        @current_employee.cid = 0
        @chat_user.save
      end
      @current_employee.save

    end

    post "/employee/chat_history" do
      @current_employee = Employee.find_by(email: session[:email])
      @messages = @current_employee.messages.split('~')
      if @current_employee.cid != 0
        msg = params[:message]
        @messages.unshift("[ #{Time.now.strftime("%b-%m-%d %H:%M:%S")} (CT) ] #{@current_employee.name.split(' ').first.capitalize}: <br /> #{msg}.~")
        @current_employee.messages = @messages.join('~')
        @current_employee.save
        @messages =  @current_employee.messages.split('~')
      else
        @messages = ["[ #{Time.now.strftime("%b-%m-%d %H:%M:%S")} (CT) ] ChatBot: <br />There is no other chatter in this chatroom!~","Welcome to Live Chat!~"]
      end
      erb :"/employee/chat_history"
    end

    post "/employee/:id/appointment" do
        @current_employee = Employee.find_by(email: session[:email])
        @appointment = Appointment.all.find_by(id: params[:id])
        redirect "/employee/#{@current_employee.id}/appointment/#{@appointment.id}"
    end

    #get "/employee/:id/index#meds" do
        #@current_employee = Employee.find_by(email: session[:email])
        #erb :"/employee/#{@current_employee.id}/index#meds"
    #end

    post "/employee/:id/prescribe" do
        @current_employee = Employee.find_by(email: session[:email])
        @med = Medicine.new
        @med.pet_id = params[:patient]
        @med.rx_name = params[:rx]
        @med.pill_count = params[:pill_count]
        @med.pill_size = params[:pill_size]
        @med.employee_id = @current_employee.id
        @med.save
        @patient = Pet.all.find_by(id: params[:patient])
        @patient.medicine_id = @med.id
        @patient.save
        redirect "/employee/#{@current_employee.id}/index#meds"
    end

    post "/employee/:id/chat" do
      @current_employee = Employee.find_by(email: session[:email])
      if (@current_employee.messages)
        @messages = @current_employee.messages.split('~')
      else
        @messages = ["Welcome to Live Chat!~"]
      end
      msg = params[:txtbox]
      if (msg.strip != '')
        @messages.unshift("[ #{Time.now.strftime("%b-%m-%d %H:%M:%S")} (CT) ] #{@current_employee.name.split(' ').first.capitalize}: <br /> #{msg}.~")
        @current_employee.messages = @messages.join('~')
        @current_employee.save
      end
      redirect "/employee/#{@current_employee.id}/index#chat"
end

    get "/employee/:id/edit" do
        @current_employee = Employee.find_by(email: session[:email])
        erb :"/employee/edit"
    end

    patch "/employee/:id/edit" do
        @current_employee = Employee.find_by(email: session[:email])
        if @current_employee.authenticate(params[:password])
            @current_employee = Employee.find_by(email: session[:email])
            @current_employee.name = params[:full_name]
            @current_employee.email = params[:email]
            @current_employee.experience = params[:experience]
            @current_employee.speciality = params[:speciality]
            @current_employee.save
            redirect "employee/#{@current_employee.id}/index"
        else
            redirect "/employee/:id/edit"
        end
    end

end
