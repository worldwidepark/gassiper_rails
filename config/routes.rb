Rails.application.routes.draw do
  get 'posts/index'
  get 'posts/create'
  get 'posts/edit'
  root to: 'sessions#new'
  resources :sessions , only: [:new, :create]
  resources :users
  
  # get 'users/create'
  # get 'users/new' ,  to: 'users#new'
  # get 'users/logout'
  # get 'users/show'
  devise_for :users
  # onlyを指定すべきだと思う。
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
