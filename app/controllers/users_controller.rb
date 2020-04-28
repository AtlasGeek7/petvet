class UsersController < ApplicationController
  def home
    @pets = current_user.pets.all if current_user
  end

  def index
    redirect_to "/users/home"
  end

  def new
    @user = User.new
  end

  def show
    @user = current_user
    render :show_user
  end

  def create
    @user = User.create(user_params)
      if @user.errors.any?
        render :new
      else
          session[:email] = @user.email
          redirect_to :root
      end
  end

  private

  def user_params
      params.require(:user).permit(:username, :email, :password)
  end

end
