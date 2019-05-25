Rails.application.routes.draw do
  get 'home/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :posts do
    resources :inappropriate_content, only: [:new, :create]
    resources :comments, only: [:create, :destroy, :edit, :update]
    resources :likes, only: [:create, :destroy]
    resources :dislikes, only: [:create, :destroy]
    resources :followers, only: [:create, :destroy]
    resources :shares, only: [:create]
    resources :dumpsters, only: [:create]
  end
  resources :users do
    resources :blacklists, only: [:create]
  end

  resources :administrators
  resources :blacklists, only: [:index, :destroy]
  resources :dumpsters, only: [:index, :destroy]




  root 'home#index'

  get 'terms_of_services' => 'registrations#terms_of_services'
  get 'aup' => 'registrations#aup'
  get 'notifications' => 'notifications#index'

  get '/log_in' => 'sessions#new', as: :sessions
  post '/login',   to: 'sessions#create', as: :log_in
  delete '/log_in' => 'sessions#destroy', as: :log_out

  get '/sign_in' => 'registrations#new', as: :registrations
  post '/sign_in' => 'registrations#create', as: :sign_in
end
