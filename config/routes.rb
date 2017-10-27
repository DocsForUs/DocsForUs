Rails.application.routes.draw do
  resources :recommendations ,only: [:new, :create]
end
