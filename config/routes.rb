Rails.application.routes.draw do

  root to: 'posts#index'

  devise_for :users, :controllers => {
    :omniauth_callbacks => "users/omniauth_callbacks",
    :registrations => 'sessions/registrations',
    :sessions => 'sessions/sessions'
  }

  namespace :info do
    resources :users , only: [:show, :update]
  end

  resources :posts , only: [:index, :new, :create,:show, :destroy] do
    resources :comments , only: [:new, :create, :destroy]
  end
end
