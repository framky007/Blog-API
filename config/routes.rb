Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "index#index", as: "index"
  resources :user

  post 'user/login' => 'user#login'

end
