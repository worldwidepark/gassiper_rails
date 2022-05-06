Rails.application.routes.draw do

  root to: 'posts#index'
  # devise_scope :user do
  #   get "/sessions/route" => "sessions_devise_controller#new"
  # end
  devise_for :users, :controllers => {
    :confirmations => 'users/confirmations',
    :sessions => 'sessions/sessions',
    :passwords => 'users/passwords' ,
    :registration => 'sessions/users'
  }


  # resources :sessions , only: [:new, :create, :destroy]
  resources :posts , only: [:index, :create, :edit]
  # onlyを指定すべきだと思う。
  # devise_for :users
  # devise_for :Sessions
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
