class InternalApiController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods
  # authenticate the request for internal API
  before_action :authenticate

  private
  def authenticate
    authenticate_or_request_with_http_token do |token|
      token == Rails.application.config.bullseye[:api_authorization_token]
    end
  end
end
