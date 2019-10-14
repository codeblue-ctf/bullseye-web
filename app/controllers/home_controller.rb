class HomeController < ApplicationController
  def index
    @config = {
      docker_registry_host: Rails.application.config.bullseye[:docker_registry_host]
    }
  end
end
