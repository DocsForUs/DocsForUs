Rails.application.routes.draw do
  root to: "index#home"
  resources :users, only: [:new, :create]
  resources :doctors, only: [:new, :create, :index, :show]
  get '/recommendations/add', to: "recommendations#add"
end
