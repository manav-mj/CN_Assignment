Rails.application.routes.draw do
  root 'dashboard#index'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'welcome', to: 'sessions#welcome'
  post 'logout', to: 'sessions#destroy'

  resources :users, only: [:new, :create]
  resources :doubts do
    resources :comments
  end
end
