Rails.application.routes.draw do

  root to: 'posts#index'

  devise_for :users, :controllers => {
    :confirmations => 'users/confirmations',
    :sessions => 'sessions/sessions',
    :passwords => 'users/passwords' ,
    :registrations => 'sessions/registrations'
  }

  devise_scope :user do
    get "/registrations/show" => "sessions/registrations#show"
    # patch "/registrations/patch" => "sessions/registrations#update"
    end
  resources :posts , only: [:index, :create, :edit, :new, :deleted]
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
