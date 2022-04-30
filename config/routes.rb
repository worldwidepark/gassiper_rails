Rails.application.routes.draw do
  root to: 'sessions#new'

  resources :sessions , only: [:new, :create, :destroy]
  resources :users
  resources :posts , only: [:index, :create, :edit]
  # onlyを指定すべきだと思う。
  devise_for :users
  # devise_for :sessions
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
