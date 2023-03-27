Rails.application.routes.draw do
  get 'sessions/new'
  # get "/ingredients", to:'ingredients#new'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get "static_pages/home"
  root "static_pages#home"

  get '/signup', to: 'users#new'
  get    "/login",   to: "sessions#new"
  post   "/login",   to: "sessions#create"
  delete "/logout",  to: "sessions#destroy"


  # post  "/inventory_item", to: "ingredient_items#create"
  resources :inventory_items, only: %i[create], controller: :ingredient_items
  resources :user_recipes, only: %i[create index destroy]
  
  resources :ingredients, only: %i[index show]
  resources :recipes, only: %i[index show]
  resources :users
  resources :tags, only: %i[show]
  
end
