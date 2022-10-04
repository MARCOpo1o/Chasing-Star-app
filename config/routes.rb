Rails.application.routes.draw do
  resources :light_pollutions
  resources :weathers
  resources :comments
  resources :posts
  resources :locations
  resources :photos
  resources :users
  root "photos#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
