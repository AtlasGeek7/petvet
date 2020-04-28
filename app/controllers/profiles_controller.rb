class ProfilesController < ApplicationController
  before_action :require_login
  before_action :set_profile, only: [:show, :edit, :update, :destroy]
  before_action :restrict_access, only: [:show, :edit]

  def new
    @profile = Profile.new
  end

  def show
  end

  def create
    @profile = Profile.create(profile_params)
    if @profile.valid?
      @profile.save
      redirect_to users_home_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    @profile.update(profile_params)
    if @profile.valid?
      redirect_to profile_path
    else
      render :new
    end
  end

  def destroy
      @profile.destroy
      redirect_to users_home_path
  end

  private
  # requiring a valid session before exposing any resources.
  def require_login
    return head(:forbidden) unless current_user
  end
  # Use callbacks to share common setup or constraints between actions.
  def set_profile
    @profile = Profile.find_by_id(params[:id])
  end
  # Adding access restrictions on resourses for non current users.
  def restrict_access
    render :"/home/http_404" unless @profile && @profile.user ==  current_user
  end
  # Never trust parameters from the scary internet, only allow the white list through.
  def profile_params
      params.require(:profile).permit(:age, :address, :gender, :full_name, :user_id)
  end

end
