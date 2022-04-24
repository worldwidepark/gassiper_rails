Rails.application.routes.draw do
  devise_for :users
  # onlyを指定すべきだと思う。
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
