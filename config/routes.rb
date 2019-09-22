require 'sidekiq/web'

Rails.application.routes.draw do
  # XXX: devise for admin should not work due to devise token auth
  #devise_for :admins

  root to: 'home#index'

  # XXX: we no longer use docker images controller because it sends many requests
  # XXX: but we might have to use this in the future when webhook endpoint breaks
  #get 'docker_images/my'

  namespace :viewer do
    %w(play table).each do |action|
        get action, action: action
    end
    get '', action: 'index'
  end

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

      # comes from docker registry
      post 'login', to: 'login#login'
      post 'registry_event', to: 'image#register'
    end
  end

  mount_devise_token_auth_for 'Team', at: 'external_api/v1/auth', skip: [:omniauth_callbacks]
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
