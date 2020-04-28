class ApplicationController < ActionController::Base
  protect_from_forgery prepend: true
  #Allows to use current_user method in the actionviews
  helper_method :current_user, :logged_in?, :current_employee , :employee_logged_in?


  # Using it for before_action: auth_req... user only able to see the page if user is logged_in
  def authentication_required
    if !logged_in?
        redirect_to login_path
    end
  end

  def logged_in?
    !!current_user
  end

  #set current user by session if there is session[:email]
  def current_user
    @current_user ||= User.find_by(email: session[:email]) if session[:email]
  end

  def employee_logged_in?
    !!current_employee
  end

  #set current employee by session if there is session[:email]
  def current_employee
    @current_employee ||= Employee.find_by(email: session[:email]) if session[:email]
  end

end
