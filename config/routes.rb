Rails.application.routes.draw do
  # get "/ingredients", to:'ingredients#new'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get "static_pages/home"
  root "static_pages#home"
  
  resources :ingredients, only: %i[index show]
  resources :recipes, only: %i[index show]
end
