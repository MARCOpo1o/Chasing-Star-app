Rails.application.routes.draw do
  root   "main_pages#home"
  get    "/signup",  to: "users#new"
  get    "/explore", to: "main_pages#explore"
  get    "/login",   to: "sessions#new"
  post   "/login",   to: "sessions#create"
  delete "/logout",  to: "sessions#destroy"
  get    "/map",     to: "maps#index"
  # get    "/post",    to: "posts#new"
  # post   "/post",    to: "posts#create"

  resources :locations do
    collection do
      get 'search'
      get 'do_search'
    end
  end
  resources :photos
  resources :users do
    resources :posts do
      resources :comments
    end
  end
  resources :user_locations
  resources :maps
  
  

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
 