Rails.application.routes.draw do

  root to: "index#home"
  resources :users, only: [:new, :create]

end
