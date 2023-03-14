Rails.application.routes.draw do
  post '/rate' => 'rater#create', :as => 'rate'
  get 'items/index'
  get 'decks/choose'
  devise_for :users, :controllers => {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  # root "articles#index"
  resources :decks, only: [:index, :new, :create, :show, :destroy] do
    member do
      get :progress
      get :close_vote
      put :hide
    end
  end
  resources :deck_items, only: [] do
    resources :votes, only: [:create]
  end
  get "items", to: "items#index"
end
