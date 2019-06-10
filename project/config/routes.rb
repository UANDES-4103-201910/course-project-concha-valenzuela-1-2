Rails.application.routes.draw do
  
  devise_for :users, controllers: { omniauth_callbacks: 'callbacks' }

  resources :users, path_names: { edit: 'change_password' } do
    get 'map' => 'users#map'
    resources :blacklists, only: [:create]
  end
  post '/create_user' => 'users#create', as: :create_user

  get 'home/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :posts do
    get 'map' => 'posts#map'
    resources :inappropriate_content, only: [:new, :create]
    resources :comments, only: [:create, :destroy, :edit, :update]
    resources :likes, only: [:create, :destroy]
    resources :dislikes, only: [:create, :destroy]
    resources :followers, only: [:create, :destroy]
    resources :shares, only: [:create]
    resources :dumpsters, only: [:create]
  end
  

  resources :administrators, path_names: { edit: 'change_password' }
  resources :blacklists, only: [:index, :destroy]
  resources :dumpsters, only: [:index, :destroy]
  resources :abusive_contents, only: [:new, :create]



  root 'home#index'

  get 'terms_of_services' => 'registrations#terms_of_services'


  get 'aup' => 'registrations#aup'
  get 'notifications' => 'notifications#index'

  delete '/log_in' => 'sessions#destroy', as: :log_out

end
