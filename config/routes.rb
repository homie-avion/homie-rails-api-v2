Rails.application.routes.draw do

  resources :messages
  resources :chats
  resources :properties
  # user routes 
  resource :users, only: [:create]
  resource :user, only: [:update, :destroy] , as: :user
  post "/login", to: "users#login"
  get "/auto_login", to: "users#auto_login"

  

end
