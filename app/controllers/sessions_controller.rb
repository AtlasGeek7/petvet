class SessionsController < ApplicationController

    def new
      @user_type = params[:user_type]
    end

    def create
      @user_type = params[:user_type]
      user = User.find_by(email: params[:email]) || Employee.find_by(email: params[:email])
      if auth
        facebook_login
      else
        validate_user(user)
      end
    end

    def destroy
        session.clear
        redirect_to root_path
    end

    private

    def auth
        request.env['omniauth.auth']
    end

    def validate_user(user)
      if params[:password].blank?
          flash[:notice] = "Password can't be blank!"
      elsif user && user.authenticate(params[:password])
          session[:email] = user.email
          #path = user.email.include?("petvet") ? employees_home_path : users_home_path
          path = user.email.include?("petvet") ? employee_path(user) : user_path(user)
          return redirect_to (path)
      else
          flash[:notice] = "Wrong password!"
      end
      if params[:email].blank?
          flash[:alert] = "Email can't be blank!"
      elsif !user
          flash[:alert] = "Wrong email!"
      end
      render :new
    end

    def facebook_login
      ouser = User.find_or_create_by(email: auth['info']['email']) do |u|
        u.username = auth['info']['name']
        u.email = auth['info']['email']
        u.password = SecureRandom.hex(32)
      end
      session[:email] = ouser.email
      redirect_to root_path
    end

end
