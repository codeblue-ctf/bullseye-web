class ApiController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods
  # XXX: only internal API is required, so we authenticate the request
  before_action :authenticate

  private
  def authenticate
    authenticate_or_request_with_http_token do |token|
      token == Rails.application.config.bullseye[:api_authorization_token]
    end
  end
end
