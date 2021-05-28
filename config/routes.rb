Rails.application.routes.draw do

  resources :messages
  resources :chats

  match "/chats/partner/:id" => "chats#get_all_chats_by_partner_id", via: [:get], as: :get_all_chats_by_partner_id
  
  resources :properties

  # user routes 
  resource :users, only: [:create]
  resource :user, only: [:update, :destroy] , as: :user
  post "/login", to: "users#login"
  get "/auto_login", to: "users#auto_login"

  

end
