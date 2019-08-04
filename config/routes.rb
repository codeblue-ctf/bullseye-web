require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :teams
  devise_for :admins

  root to: 'home#index'
  get 'docker_images/my'
  get 'viewer(/:action)', :controller => 'viewer'

  # interface for admin
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
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
      resources :problems, only: [:index, :show]

      # this is for viewer
      get 'viewer/teams', to: 'viewer#teams'
      get 'viewer/table', to: 'viewer#table'
      get 'viewer/problems', to: 'viewer#problems'
      get 'viewer/score/:id', to: 'viewer#score'
    end
  end

  get '*path', to: 'home#index'
end
