Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # resources :sessions, only: [:new, :create, :destroy]
  root to: "index#home"
  resources :users, except: [:edit, :destroy] do
    collection do
      get 'find'
    end
  end
  resources :doctors do
    collection do
      get 'find'
    end
  end
  resources :recommendations, only: [:new, :create, :edit, :update, :destroy]

  post '/save' => 'doctor_users#create'
  delete '/remove' => 'doctor_users#destroy'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'
  get '/about' => 'index#about'
  get '/resources' => 'index#resources'
  get '/check' => 'users#check'
  post '/check' => 'users#doc_search'
  get '/doctor_new' => 'users#doctor_new'
  post '/doctor_create' => 'users#doctor_create'
  get '/doctor_signup' => 'users#doctor_signup'

  get '/recommendations/add', to: "recommendations#add"
end
