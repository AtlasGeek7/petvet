Rails.application.routes.draw do


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

get 'login' => 'sessions#new'
post '/login' => 'sessions#create'
get '/logout' => 'sessions#destroy'
get '/users/home' => 'users#home', as: "users_home"
get '/employees/home' => 'employees#home', as: "employees_home"
post "/sessions" => "sessions#create"
get '/auth/facebook/callback' => 'sessions#create'
resources :users, only: [:new, :create, :show, :index]
resources :employees
resources :profiles
resources :pets
resources :appointments
resources :medicines
root 'home#index'

resources :pets, only: [:show] do
  resources :medicines, only: [:index]
end

resources :employees do
  resources :medicines
end
end
