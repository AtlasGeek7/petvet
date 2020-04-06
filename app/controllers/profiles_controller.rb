class ProfilesController < ApplicationController
  get '/profiles' do
    if logged_in?
        @profile = current_user.profile
        if @profile && @profile.user == current_user
          redirect to "/profiles/#{current_user.id}"
        else
          redirect to '/http_404'
        end
    else
      redirect to '/login'
    end
  end

  get '/profiles/new' do
    if logged_in?
      erb :'profiles/create_profile'
    else
      redirect to '/login'
    end
  end

  post '/profiles' do
    if logged_in?
        @profile = current_user.create_profile(full_name: params[:full_name], age: params[:age], gender: params[:gender], address: params[:address])
        if @profile.save
          redirect to "/profiles/#{@profile.id}"
        else
          redirect to "/profiles/new"
        end
    else
      redirect to '/login'
    end
  end

  get '/profiles/:id' do
    if logged_in?
      @profile = Profile.find_by_id(params[:id])
      if @profile && @profile.user == current_user
        erb :'profiles/info'
      else
        redirect to '/http_404'
      end
    else
      redirect to '/login'
    end
  end

  get '/profiles/:id/edit' do
    if logged_in?
      @profile = Profile.find_by_id(params[:id])
      if @profile && @profile.user == current_user
        erb :'profiles/edit_profile'
      else
        redirect to '/http_404'
      end
    else
      redirect to '/login'
    end
  end

  patch '/profiles/:id' do
    if logged_in?
        @profile = Profile.find_by_id(params[:id])
        if @profile && @profile.user == current_user
          if @profile.update(full_name: params[:full_name], age: params[:age], gender: params[:gender], address: params[:address])
            redirect to "/profiles/#{@profile.id}"
          else
            redirect to "/profiles/#{@profile.id}/edit"
          end
        else
          redirect to '/'
        end
    else
      redirect to '/login'
    end
  end

  delete '/profiles/:id/delete' do
    if logged_in?
      @profile = Profile.find_by_id(params[:id])
      if @profile && @profile.user == current_user
        @profile.delete
      end
      redirect to '/'
    else
      redirect to '/login'
    end
  end
end
