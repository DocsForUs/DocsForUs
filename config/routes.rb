Rails.application.routes.draw do
  resources :recommendations, only: [:new, :create]
  resources :doctors, only: [:new]
end
