require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :teams
  devise_for :admins
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :problems, only: [:index, :show]
  get 'home/index'
  root to: 'home#index'
  get 'docker_images/my'
  get 'viewer(/:action)', :controller => 'viewer'

  # interface for admin
  authenticate :admin do
    mount Sidekiq::Web, at: "/sidekiq"
    get 'docker_images/all'
    get 'schedules/new'
    post 'schedules/create_macro'
  end

  namespace :internal_api, { format: :json } do
    namespace :v1 do
      post 'submit_score', to: 'schedule_results#submit'
      post 'login', to: 'authorization#login'
      post 'registry_event', to: 'image#register'
    end
  end

  namespace :external_api, { format: :json } do
    namespace :v1 do
      get 'teams', to: 'viewer#teams'
      get 'table', to: 'viewer#table'
      get 'problems', to: 'viewer#problems'
      get 'score/:id', to: 'viewer#score'
    end
  end
end
