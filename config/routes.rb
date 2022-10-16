Rails.application.routes.draw do
  resources :light_pollutions
  resources :weathers
  resources :comments
  resources :posts
  resources :locations
  resources :photos
  resources :users
  resources :user_locations
  get "/explore", to:"main_pages#explore"
  root "main_pages#home"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
