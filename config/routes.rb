Rails.application.routes.draw do

  devise_for :users, controllers: { registrations: 'registrations' }

  devise_scope :user do
    get 'users/admin_sign_up', to: 'registrations#new_admin', as: :new_admin_registration
    post 'users/admin_sign_up', to: 'registrations#create_admin', as: :create_admin_registration
  end

  resources :clubs, only: [:index, :show, :edit, :update, :create, :new] do
    resources :quinielas, only: [:new, :create, :edit, :update]

  end
  resources :users, only: [:show, :edit, :update]

  root "pages#home"
  get "/search", to: "clubs#search"
  get 'rules', to: 'pages#rules'

  #get '/user/:id', to: 'users#show', as: 'user_profile'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")


  resources :quinielas, only: [:show] do
    member do
      get :winners
    end
    resources :predictions, only: [:new, :create, :show]
  end

  resources :clubs do
    member do
      post :follow
      delete :unfollow
    end
  end
end
