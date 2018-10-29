class ExternalApiController < ActionController::API
  before_action :authenticate_admin!
  def index
  end
end
