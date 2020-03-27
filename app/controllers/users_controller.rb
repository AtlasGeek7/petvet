class UsersController < ApplicationController
    get "/user_logout" do
        user_logout!
    end

    get "/users/home" do
      erb :"/users/home"
    end

    get "/users/employees_status" do
      @current_user = User.find_by(email: session[:email])
      if @current_user
        if @current_user.cid == 0
          erb :"/users/employees_status"
        end
      end
    end

    get "/users/chat_history" do
      @current_user = User.find_by(email: session[:email])
      ecid = @current_user.cid
      if (ecid != 0)
        @chat_employee = Employee.find_by(id: ecid)
        @messages = @chat_employee.messages.split('~')
      else
        @messages = ["Welcome to Live Chat!"]
      end
      erb :"/users/chat_history"
    end

    post "/users/chat_init" do
      @current_user = User.find_by(email: session[:email])
      @chat_employee = Employee.find_by(id: params[:ecid])
      @chat_employee.cid = @current_user.id
      @chat_employee.save
      @current_user.cid = params[:ecid]
      @current_user.save
    end

    post "/users/chat_history" do
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
    end

    get "/users/:id/chat" do
      @current_user = User.find_by(email: session[:email])
      #@current_user.messages = "[Mar-03-06 02:32:54 (CT)] Kat Nip says: testing...~"
      @messages = @current_user.messages.split('~')
      #@current_user.save
      erb :"/users/chat"
    end

    post "/users/home" do
        users = User.all.map { |u| u.email}
        if users.include?(params[:email]) && params[:cmd] == "signup"
          erb :"/users/home", locals: {error: "&bull; E-mail already in use!"}
        elsif !(users.include?(params[:email])) && params[:cmd] == "signup"
            @user = User.new(email: params[:email], password: params[:password])
            #@user.messages = "Welcome to Live Chat!~"
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
      if (logged_in?)
        @current_user = User.find_by(email: session[:email])
        @appointment_ids = Appointment.all.pluck(:user_id)   
        @current_user.pets.each do |p|
          if p.medicines.size > 0
              @medicine = p.medicines
          end
        end
        if @appointment_ids.include?(@current_user.id)
            @appointment = Appointment.find_by(user_id: @current_user.id)
            @doctor = Employee.find_by(id: @appointment.employee_id)
        end
        erb :"/users/home"
      else
        redirect "/"
      end
    end

    post "/users/:id/form" do
        @current_user = User.find_by(email: session[:email])
        cnt = 0
        if (params[:cmd] != "add_pet")
        @detail = UserDetails.new
        @detail.full_name = format_str(params[:full_name])
        @detail.dob = params[:dob]
        @detail.gender = params[:gender].capitalize
        @detail.address = format_str(params[:address])
        @detail.phone_number = params[:phone_number]
        @detail.user_id = @current_user.id
        @detail.save
        len = @current_user.pets.all.size


        len.times { |i|
          cmd = "cmd#{i}".to_sym
          petid = "petid#{i}".to_sym
          cnt += 1
          if (params[cmd] == "update#{i}")
            @pet = @current_user.pets.all.find_by(id: params[petid])
          end
        }
      end
        if (cnt == 0)
          @pet = Pet.new
        end
        @pet.name = params[:pet_name]
        @pet.age = params[:pet_age]
        @pet.gender = params[:pet_gender]
        @pet.breed = params[:breed]
        @pet.user = @current_user
        @pet.save



        redirect "/users/#{@current_user.id}/home#about"

    end

    get "/users/:id/edit" do
        @current_user = User.find_by(email: session[:email])
        erb :"/users/edit"
    end

    patch "/users/:id/edit" do
        @current_user = User.find_by(email: session[:email])

        if !@current_user.authenticate(params[:password])
            redirect "/users/:id/edit"
        else
            user = User.find_by(id: @current_user.id)
            user.user_details.full_name = params[:full_name]
            user.user_details.phone_number = params[:phone_number]
            user.user_details.address = params[:address]
            user.email = params[:email]
            user.password = params[:password]
            user.user_details.gender = @current_user.user_details.gender
            user.user_details.dob = @current_user.user_details.dob
            user.user_details.user_id = @current_user.id
            user.user_details.medicine_id = @current_user.user_details.medicine_id
            user.user_details.save
            user.save
            redirect "/users/#{@current_user.id}/index"
        end
    end

    post "/users/:id/chat" do
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
    end

    post '/users/:id/delpet' do
        id = params[:petid]
        pet = Pet.find(id)

        pet.destroy
        @current_user = User.find_by(email: session[:email])
        redirect "/users/#{@current_user.id}/home#about"
    end

    post '/users/:id/upload' do
      if (params[:file])
        @filename = params[:file][:filename]
        file = params[:file][:tempfile]
        if (params[:petid])
          @pet = Pet.find(params[:petid])
          @pet.img = "/img/#{@filename}"
          @pet.save
        else
          @current_user = User.find_by(email: session[:email])
          @current_user.img = "/img/#{@filename}"
          @current_user.save
        end
        File.open("./././public/img/#{@filename}", 'wb') do |f|
          f.write(file.read)
        end
      end
        redirect '/users/:id/home#about'
    end


end
