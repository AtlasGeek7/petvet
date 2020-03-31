class EmployeeController < ApplicationController

    get "/employee_logout" do

      if session[:email]
        employee_logout!
      else
        redirect "/employee/index"
      end

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

      if session[:email]
        @current_employee = Employee.find_by(email: session[:email])
        erb :"/employee/index"
      else
        redirect "/users/home"
      end

    end

    get "/employee/status" do

      if session[:email]
      @current_employee = Employee.find_by(email: session[:email])
      if @current_employee
        if @current_employee.cid != 0
          @bool = 'checked'
        else
          @bool = ''
        end
      end
      erb :"/employee/status"
    else
      redirect "/users/home"
    end

    end

    get "/employee/chat_history" do

      if session[:email]
      @current_employee = Employee.find_by(email: session[:email])
      if @current_employee && @current_employee.cid != 0
        @messages = @current_employee.messages.split('~')
        erb :"/employee/chat_history"
      end
    else
      redirect "/users/home"
    end

    end



    post "/employee/update_status" do

      if session[:email]
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
      else
        redirect "/users/home"
      end

    end

    post "/employee/chat_history" do

      if session[:email]
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
      else
        redirect "/"
      end

    end

    post "/employee/:id/prescribe" do

      if session[:email]
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
      else
        redirect "/employee/index"
      end

    end

end
