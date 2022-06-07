Rails.application.routes.draw do

  root to: 'posts#index'

  devise_for :users, :controllers => {
    :registrations => 'sessions/registrations',
    :sessions => 'sessions/sessions',
    :omniauth_callbacks =>'users/omniauth_callbacks'
  }

  devise_scope :user do
    get "/registrations/show" => "sessions/registrations#show"
  end

  namespace :info do
    resources :users , only: [:show, :update]
  end

  resources :posts , only: [:index, :new, :create,:show, :destroy] do
    resources :comments , only: [:new, :create, :destroy]
  end
end
