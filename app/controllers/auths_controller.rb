class AuthsController < ApplicationController
  before_action :attempt_authentication_against_application_tokens

  def attempt_authentication_against_application_tokens
    team = authenticate_with_http_basic do |email, password|
      team = Team.find_by(email: email)
      team if team&.valid_password?(password)
    end
    sign_in(team, store: true) if team
  end

  def show
    authenticate_team! if request.headers["Authorization"]
    #registry = Registry.by_hostname_or_external(params[:service])

    #auth_scopes = []
    #auth_scopes = authorize_scopes(registry) unless registry.nil?

    #token = Portus::JwtToken.new(params[:account], params[:service], auth_scopes)
    #logger.tagged("jwt_token", "claim") { logger.debug token.claim }
    #render json: token.encoded_hash
    render json: {}
  end
end
