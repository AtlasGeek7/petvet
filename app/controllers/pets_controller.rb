class PetsController < ApplicationController

  post "/pets/:id/update" do

    if session[:email]
      @pet = Pet.find(params[:id])
      @pet.name = params[:pet_name]
      @pet.age = params[:pet_age]
      @pet.gender = params[:pet_gender]
      @pet.breed = params[:breed]
      @pet.save
      redirect "/users/#{@pet.user_id}/home#about"
    else
      redirect "/users/home"
    end

  end

  post "/pets/:id/add" do

    if session[:email]
      @pet = Pet.new
      @pet.name = params[:pet_name]
      @pet.age = params[:pet_age]
      @pet.gender = params[:pet_gender]
      @pet.breed = params[:breed]
      @pet.user_id = params[:id]
      @pet.save
      redirect "/users/#{params[:id]}/home#about"
    else
      redirect "/users/home"
    end

  end

  post "/pets/:id/delpet" do

    if session[:email]
      @pet = Pet.find(params[:id])
      @pet.destroy
      redirect "/users/#{@pet.user_id}/home#about"
    else
      redirect "/users/home"
    end

  end

  post "/pets/:id/uploadpic" do

    if session[:email]
      if (params[:file])
        @filename = params[:file][:filename]
        file = params[:file][:tempfile]
        @pet = Pet.find(params[:id])
        @pet.img = "/img/#{@filename}"
        @pet.save
        File.open("./././public/img/#{@filename}", 'wb') do |f|
          f.write(file.read)
        end
        redirect "/users/#{@pet.user_id}/home#about"
      end
    else
      redirect "/users/home"
    end

  end


end
