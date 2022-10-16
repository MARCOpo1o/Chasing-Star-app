Rails.application.routes.draw do
  resources :user_locations
  root "main_pages#home"
  get "/explore", to:"main_pages#explore"
  get "/photos", to: "photos#index"
  resources :light_pollutions
  resources :weathers
  resources :comments
  resources :posts
  resources :locations
  resources :photos
  resources :users

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
