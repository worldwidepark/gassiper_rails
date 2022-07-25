Rails.application.routes.draw do

  root to: 'posts#index'
  devise_for :users,
    :controllers => {
    :omniauth_callbacks => "users/omniauth_callbacks",
    :registrations => 'sessions/registrations',
    :sessions => 'sessions/sessions'
  }
  resources :users , only: [:show, :update]
  resources :posts , only: [:index, :new, :create, :show, :destroy] do
    resources :comments , only: [:new, :create, :destroy]
  end
  resource :likes, only: [:new, :create, :destroy]
  resource :follows, only: [:create, :destroy]
  resource :searchs, only: [:show]
end

