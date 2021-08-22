Rails.application.routes.draw do
  root to: 'toppages#index'
  
  get 'signup', to: 'users#new'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  
  
  resources :users, only: [:index, :show, :create] do
     member do 
       get :followings
       get :followers
       get :favorites
     end
     collection do
      get :search
     end
  end
  
  resources :places, only: [:new, :create, :edit, :update, :destroy]
  
  resources :relationships, only: [:create, :destroy]
  
  resources :favorites, only: [:create, :destroy]
end
