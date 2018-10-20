Rails.application.routes.draw do
  devise_for :teams
  devise_for :admins
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :problems, only: [:index, :show]
  get 'home/index'
  root to: 'home#index'
  get 'logs/submit_log'

  namespace :api, { format: :json } do
    namespace :v1 do
      post 'submit_score', to: 'schedule_results#submit'
    end
  end
end
