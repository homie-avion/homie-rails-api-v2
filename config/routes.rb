Rails.application.routes.draw do

  resources :messages
  resources :chats

  match "/chats/partner/:id" => "chats#get_all_chats_by_partner_id", via: [:get], as: :get_all_chats_by_partner_id
  
  resources :properties

  match "/recommendations" => "properties#get_properties_based_on_preferences", via: [:post], as: :get_properties_based_on_preferences
  match "/property/:id" => "properties#get_property", via: [:get], as: :get_property

  # resources :preferences, only: [:index]
  match "/do_get_preferences" => "preferences#do_get_preferences", via: [:get], as: :do_get_preferences
  match "/update_preferences" => "preferences#do_update_preferences", via: [:post], as: :do_update_preferences
  # user routes 
  resource :users, only: [:create]
  resource :user, only: [:update, :destroy] , as: :user
  post "/login", to: "users#login"
  get "/auto_login", to: "users#auto_login"

  

end
