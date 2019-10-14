Rails.application.routes.draw do
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
  
  # XXX: devise for admin should not work due to devise token auth
  devise_for :admins

  scope :admin do
    authenticate :admin do
      get 'docker_images/all'
      get 'schedules/new_macro'
      post 'schedules/create_macro'
    end
  end
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  namespace :internal_api, { format: :json } do
    namespace :v1 do
      post 'submit_score', to: 'scores#submit'

      # comes from docker registry
      post 'login', to: 'login#login'
      post 'registry_event', to: 'image#register'
    end
  end

  mount_devise_token_auth_for 'Team', at: 'external_api/v1/auth', skip: [:omniauth_callbacks]
  namespace :external_api, { format: :json } do
    namespace :v1 do
      resources :problems, only: [:index, :show]

      get 'current_team', to: 'auth#show_current_team'

      # this is for viewer
      get 'viewer/teams', to: 'viewer#teams'
      get 'viewer/table', to: 'viewer#table'
      get 'viewer/problems', to: 'viewer#problems'
      get 'viewer/score/:id', to: 'viewer#score'
    end
  end

  get '*path', to: 'home#index'
end
