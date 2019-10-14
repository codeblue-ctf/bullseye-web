class ExternalApi::V1::AuthController < ExternalApiController
  before_action :authenticate_team!, only: [:current_team]

  def login
  end
  def show_current_team
    render json: {
      current_team: {
        name: current_team.name,
        login_name: current_team.login_name
      }
    }
  end
end
