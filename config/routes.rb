Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # resources :sessions, only: [:new, :create, :destroy]
  root to: "index#home"
  resources :users, only: [:new, :create]
  resources :doctors, only: [:index]
  resources :recommendations, only: [:new, :create]
  resources :tags, only: :create
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'
  get '/recommendations/add', to: "recommendations#add"
end
