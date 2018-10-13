Rails.application.routes.draw do
  devise_for :teams
  devise_for :admins
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :problems, only: [:index, :show]
  resource :auth
  get 'home/index'
  root to: 'home#index'

  get 'logs/submit_log'
end
