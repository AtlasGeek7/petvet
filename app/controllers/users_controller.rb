class UsersController < ApplicationController

    get "/user_logout" do
      if session[:email]
        user_logout!
      else
        redirect "/users/home"
      end
    end

    get "/users/home" do
      erb :"/users/home"
    end

    get "/users/employees_status" do

      if session[:email]
        @current_user = User.find_by(email: session[:email])
        if @current_user
          if @current_user.cid == 0
            erb :"/users/employees_status"
          end
        end
      else
        redirect "/users/home"
      end

    end

    get "/users/chat_history" do

      if session[:email]
        @current_user = User.find_by(email: session[:email])
        if @current_user
          ecid = @current_user.cid
        else
          ecid = 0
        end
        if (ecid != 0)
          @chat_employee = Employee.find_by(id: ecid)
          @messages = @chat_employee.messages.split('~')
        else
          @messages = ["Welcome to Live Chat!"]
        end
        erb :"/users/chat_history"
      else
        redirect "/users/home"
      end

    end

    post "/users/chat_init" do

      if session[:email]
        @current_user = User.find_by(email: session[:email])
        @chat_employee = Employee.find_by(id: params[:ecid])
        @chat_employee.cid = @current_user.id
        @chat_employee.messages = "[ #{Time.now.strftime("%b-%m-%d %H:%M:%S")} (CT) ] ChatBot: <br />#{@current_user.user_details.full_name.split(' ').first.capitalize} & #{@chat_employee.name.split(' ').first.capitalize} #{@chat_employee.name.split(' ').last[0].capitalize}. entered the chatroom.!~ Welcome to Live Chat!~"
        @chat_employee.save
        @current_user.cid = params[:ecid]
        @current_user.save
      else
        redirect "/users/home"
      end

    end

    post "/users/chat_history" do

      if session[:email]
        @current_user = User.find_by(email: session[:email])
        ecid = @current_user.cid
        if (ecid != 0)
          @chat_employee = Employee.find_by(id: ecid)
          @messages = @chat_employee.messages.split('~')
          msg = params[:message]
          @messages.unshift("[ #{Time.now.strftime("%b-%m-%d %H:%M:%S")} (CT) ] #{@current_user.user_details.full_name.split(' ').first.capitalize}: <br /> #{msg}.~")
           @chat_employee.messages = @messages.join('~')
           @chat_employee.save
          @messages =  @chat_employee.messages.split('~')
        else
          @messages = ["[ #{Time.now.strftime("%b-%m-%d %H:%M:%S")} (CT) ] ChatBot: <br />Please choose an available PetVet chatter!~", "Welcome to Live Chat!~"]
        end
        erb :"/users/chat_history"
      else
        redirect "/users/home"
      end

    end

    post "/users/home" do

        users = User.all.map { |u| u.email}
        if users.include?(params[:email]) && params[:cmd] == "signup"
          erb :"/users/home", locals: {error: "&bull; E-mail already in use!"}
        elsif !(users.include?(params[:email])) && params[:cmd] == "signup"
            @user = User.new(email: params[:email], password: params[:password])
            @user.cid = 0
            @user.save
                redirect "/users/home"
        elsif users.include?(params[:email]) && params[:cmd] == "login"
          login(params[:email], params[:password])
          @current_user = User.find_by(email: session[:email])
          redirect "/users/#{@current_user.id}/home"
        elsif !(users.include?(params[:email])) && params[:cmd] == "login"
          erb :"/users/home", locals: {error: "&bull; Wrong credentials!"}
        end

    end

    get "/users/:id/home" do

      if session[:email]
        if (logged_in?)
          @current_user = User.find_by(email: session[:email])
          @appointment_ids = Appointment.all.pluck(:user_id)
          @pets = @current_user.pets.all
          if @appointment_ids.include?(@current_user.id)
              @appointment = Appointment.find_by(user_id: @current_user.id)
              @doctor = Employee.find_by(id: @appointment.employee_id)
          end
          @review = Review.all.find_by(user_id: @current_user.id)
          @employees = Employee.all
          erb :"/users/home"
        else
          redirect "/"
        end
      else
        redirect "/users/home"
      end


    end

    post "/users/:id/form" do

      if session[:email]
          @current_user = User.find_by(email: session[:email])
          @detail = UserDetails.new
          @detail.full_name = params[:full_name]
          @detail.dob = params[:dob]
          @detail.gender = params[:gender].capitalize
          @detail.address = params[:address]
          @detail.phone_number = params[:phone_number]
          @detail.user_id = @current_user.id
          @detail.save
          @pet = Pet.new
          @pet.name = params[:pet_name]
          @pet.age = params[:pet_age]
          @pet.gender = params[:pet_gender]
          @pet.breed = params[:breed]
          @pet.user = @current_user
          @pet.save
          redirect "/users/#{@current_user.id}/home#about"
        else
          redirect "/users/home"
        end

    end

    post "/users/:id/chat" do

      if session[:email]
        @current_user = User.find_by(email: session[:email])
        if (@current_user.messages)
          @messages = @current_user.messages.split('~')
        else
          @messages = ["Welcome to Live Chat!~"]
        end
        msg = params[:txtbox]
        if (msg.strip != '')
          @messages.unshift("[ #{Time.now.strftime("%b-%m-%d %H:%M:%S")} (CT) ] #{@current_user.user_details.full_name.split(' ').first.capitalize}: <br /> #{msg}.~")
          @current_user.messages = @messages.join('~')
          @current_user.save
        end
        redirect "/users/#{@current_user.id}/home#chat"
      else
        redirect "/users/home"
      end
    end

    post '/users/:id/uploadpic' do

      if session[:email]
        if (params[:file])
          filename = params[:file][:filename]
          file = params[:file][:tempfile]
          @current_user = User.find_by(email: session[:email])
          @current_user.img = "/img/#{filename}"
          @current_user.save
          File.open("./././public/img/#{filename}", 'wb') do |f|
            f.write(file.read)
          end
          redirect "/users/#{params[:id]}/home#about"
        end
      else
        redirect "/users/home"
      end

    end

end
