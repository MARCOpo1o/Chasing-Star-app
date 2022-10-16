Rails.application.routes.draw do
  root "main_pages#home"
  get  "/signup",  to: "users#new"
  get "/explore", to: "main_pages#explore"
  resources :light_pollutions
  resources :weathers
  resources :comments
  resources :posts
  resources :locations
  resources :photos
  resources :users
  resources :user_locations
  

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
