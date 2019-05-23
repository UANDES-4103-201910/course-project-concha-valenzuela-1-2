Rails.application.routes.draw do
  get 'home/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :posts do
    resources :inappropriate_content, only: [:new, :create]
  end

  resources :users

  resources :administrators
  resources :blacklists
  resources :dumpsters




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
