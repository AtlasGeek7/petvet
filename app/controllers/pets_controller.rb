class PetsController < ApplicationController
  
  before_action :require_login
  before_action :set_pet, only: [:show, :edit, :update, :destroy]
  before_action :restrict_access, only: [:show, :edit]

  def index
    if params[:employee_id]
      @pets = Pet.all
    end
    @pets = current_user.pets.all
  end

  def new
    @pet = Pet.new
  end

  def show
  end

  def create
    @pet = Pet.create(pet_params)
    if @pet.valid?
      @pet.save
      redirect_to pet_path(@pet)
    else
      render :new
    end
  end

  def edit
  end

  def update
    @pet.update(pet_params)
    if @pet.valid?
      redirect_to pet_path
    else
      render :new
    end
  end

  def destroy
      @pet.destroy
      redirect_to pets_path
  end

  private
    # requiring a valid session before exposing any resources.
    def require_login
      return head(:forbidden) unless current_user
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_pet
      @pet = Pet.find_by_id(params[:id])
    end
    # Adding access restrictions on resourses for non current users.
    def restrict_access
      render :"/home/http_404" unless @pet && @pet.user == current_user
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def pet_params
        params.require(:pet).permit(:age, :breed, :gender, :name, :user_id)
    end

end
