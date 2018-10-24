require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :teams
  devise_for :admins
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :problems, only: [:index, :show]
  get 'home/index'
  root to: 'home#index'
  get 'logs/submit_log'

  # sidekiq web interface
  authenticate :admin do
    mount Sidekiq::Web, at: "/sidekiq"
  end

  namespace :api, { format: :json } do
    namespace :v1 do
      post 'submit_score', to: 'schedule_results#submit'
    end
  end
end
