Rails.application.routes.draw do
  devise_for :users
  resources :clubs, only: [:index, :show, :edit, :update, :create, :new] do
    resources :quinielas, only: [:new, :create]
  end
  resources :users, only: [:show]
  root "pages#home"
  get "/search", to: "clubs#search"
  #get '/user/:id', to: 'users#show', as: 'user_profile'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")

  resources :quinielas, only: [:show] do
    resources :predictions, only: [:new, :create]
  end

  # root "posts#index"
end
