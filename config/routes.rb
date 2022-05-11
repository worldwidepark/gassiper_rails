Rails.application.routes.draw do

  root to: 'posts#index'

  devise_for :users, :controllers => {
    :confirmations => 'users/confirmations',
    :sessions => 'sessions/sessions',
    :passwords => 'users/passwords' ,
    :registrations => 'sessions/registrations'
  }
  devise_scope :user do
    get "/user/show" => "sessions/users#show"
    patch "/users/patch" => "sessions/users#update"
    end
  
  # get 'user/show', to: 'sessions/users#show' 
  # resources :sessions , only: [:new, :create, :destroy]
  resources :posts , only: [:index, :create, :edit]
  # onlyを指定すべきだと思う。
  # devise_for :users
  # devise_for :Sessions
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
