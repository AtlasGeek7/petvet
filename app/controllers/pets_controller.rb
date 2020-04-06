class PetsController < ApplicationController
  get '/pets' do
    if logged_in?
      @pets = current_user.pets.all
      erb :'pets/pets'
    else
      redirect to '/login'
    end
  end

  get '/pets/new' do
    if logged_in?
      erb :'pets/create_pet'
    else
      redirect to '/login'
    end
  end

  post '/pets' do
    if logged_in?
        @pet = current_user.pets.build(name: params[:pet_name], age: params[:pet_age], gender: params[:pet_gender], breed: params[:pet_breed])
        if @pet.save
          redirect to "/pets/#{@pet.id}"
        else
          redirect to "/pets/new"
        end
    else
      redirect to '/login'
    end
  end

  get '/pets/:id' do
    if logged_in?
      @pet = Pet.find_by_id(params[:id])
      if @pet && @pet.user == current_user
        erb :'pets/show_pet'
      else
        redirect to '/http_404'
      end
    else
      redirect to '/login'
    end
  end

  get '/pets/:id/edit' do
    if logged_in?
      @pet = Pet.find_by_id(params[:id])
      if @pet && @pet.user == current_user
        erb :'pets/edit_pet'
      else
        redirect to '/pets'
      end
    else
      redirect to '/login'
    end
  end

  patch '/pets/:id' do
    if logged_in?
        @pet = Pet.find_by_id(params[:id])
        if @pet && @pet.user == current_user
          if @pet.update(name: params[:pet_name], age: params[:pet_age], gender: params[:pet_gender], breed: params[:pet_breed])
            redirect to "/pets/#{@pet.id}"
          else
            redirect to "/pets/#{@pet.id}/edit"
          end
        else
          redirect to '/pets'
        end
    else
      redirect to '/login'
    end
  end

  delete '/pets/:id/delete' do
    if logged_in?
      @pet = Pet.find_by_id(params[:id])
      if @pet && @pet.user == current_user
        @pet.delete
      end
      redirect to '/pets'
    else
      redirect to '/login'
    end
  end
end
