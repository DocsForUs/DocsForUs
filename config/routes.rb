Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # resources :sessions, only: [:new, :create, :destroy]
  root to: "index#home"
  resources :users, except: [:edit, :destroy]
  resources :doctors, except: [:edit, :update] do
    collection do
      get 'find'
    end
  end

  resources :recommendations, only: [:new, :create, :destroy]

  post '/save' => 'doctor_users#create'
  delete '/remove' => 'doctor_users#destroy'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'
  get '/about' => 'index#about'
  get '/resources' => 'index#resources'

  get '/recommendations/add', to: "recommendations#add"
end
