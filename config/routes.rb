Rails.application.routes.draw do

  root to: 'posts#index'
  resources :users , only: [:show, :update] , path: 'users/show'
  devise_for :users,
    :controllers => {
    :omniauth_callbacks => "users/omniauth_callbacks",
    :registrations => 'sessions/registrations',
    :sessions => 'sessions/sessions'
  }



  resources :posts , only: [:index, :new, :create,:show, :destroy] do
    resources :comments , only: [:new, :create, :destroy]
  end
end

