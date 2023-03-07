Rails.application.routes.draw do
  get 'items/index'
  get 'decks/choose'
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  # root "articles#index"
  resources :decks, only: [:index, :new, :create]
  get "items", to: "items#index"
end
