Rails.application.routes.draw do

  root to: 'posts#index'

  devise_for :users, :controllers => {
    :confirmations => 'users/confirmations',
    :sessions => 'sessions/sessions',
    :passwords => 'users/passwords' ,
    :registrations => 'sessions/registrations'
  }
<<<<<<< HEAD
  devise_scope :user do
    get "/registrations/show" => "sessions/registrations#show"
    # patch "/registrations/patch" => "sessions/registrations#update"
    end
  
  # get 'user/show', to: 'sessions/users#show' 
  # resources :sessions , only: [:new, :create, :destroy]
=======
>>>>>>> origin/create_session
  resources :posts , only: [:index, :create, :edit]
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
