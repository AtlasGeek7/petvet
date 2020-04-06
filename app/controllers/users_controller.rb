class UsersController < ApplicationController
  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    redirect to '/'
  end

  get '/signup' do
    if !logged_in?
      erb :'users/sign_up', locals: {message: "Please sign up before you sign in"}
    else
      redirect to '/'
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect to '/signup'
    else
      if !(User.exists?(username: params[:username])) && !(User.exists?(email: params[:email]))
        @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
        @user.save
        session[:user_id] = @user.id
        redirect to '/'
      elsif User.exists?(username: params[:username])
        erb :'users/sign_up', locals: {message: "Username already in use!"}
      elsif User.exists?(email: params[:email])
        erb :'users/sign_up', locals: {message: "Email already in use!"}
      end
    end
  end

  get '/login' do
    if !logged_in?
      erb :'users/login'
    else
      redirect to '/'
    end
  end

  post '/login' do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to "/"
    else
      redirect to '/signup'
    end
  end

  get '/logout' do
    if logged_in?
      session.destroy
      redirect to '/login'
    else
      redirect to '/'
    end
  end
end
