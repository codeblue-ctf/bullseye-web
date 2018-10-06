RailsAdmin.config do |config|
  config.bullseye = {
    bullseye_runner_host: ENV.fetch('BULLSEYE_RUNNER_HOST') { 'localhost:3001' },
    docker_registry_host: ENV.fetch('DOCKER_REGISTRY_HOST') { 'localhost:3002' },
    docker_registry_auth_host: ENV.fetch('DOCKER_REGISTRY_AUTH_HOST') { 'localhost:3003' }
  }
end
