Rails.application.routes.draw do
  root   "main_pages#home"
  get    "/signup",  to: "users#new"
  get    "/explore", to: "main_pages#explore"
  get    "/login",   to: "sessions#new"
  post   "/login",   to: "sessions#create"
  delete "/logout",  to: "sessions#destroy"
  get    "/map",     to: "maps#index"
  get    "/detail1",     to: "locations#detail1"
  get    "/detail2",     to: "locations#detail2"
  # get    "/post",    to: "posts#new"
  # post   "/post",    to: "posts#create"

  resources :locations
  resources :photos
  resources :users do
    resources :posts
  end
  resources :user_locations
  resources :maps
  
  

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
 