Rails.application.routes.draw do
  get 'decks/choose'
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get "decks", to: "decks#index"
  get "decks", to: "decks#choose"
end
