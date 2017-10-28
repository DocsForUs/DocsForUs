Rails.application.routes.draw do
  root to: "index#home"
  resources :users, only: [:new, :create]
  resources :doctors, only: [:index]

  get '/recommendations/new', to: "recommendations#new"
  get '/recommendations/add', to: "recommendations#add"
end
