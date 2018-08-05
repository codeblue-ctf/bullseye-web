Rails.application.routes.draw do
  resources :problems
  resource :auth
  devise_for :teams
  get 'home/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "home#index"
end
