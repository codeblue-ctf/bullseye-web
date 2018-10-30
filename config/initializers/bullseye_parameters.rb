Rails.application.config.bullseye = {
  runner_host: ENV['BULLSEYE_RUNNER_HOST'] || 'localhost:3001',
  web_host: ENV['BULLSEYE_WEB_URL'] || 'localhost:3000',
  docker_registry_host: ENV['DOCKER_REGISTRY_HOST'] || 'localhost:5000',
  docker_registry_auth_host: ENV['DOCKER_REGISTRY_AUTH_HOST'] || 'localhost:5001',
  api_authorization_token: ENV['BULLSEYE_API_AUTH_TOKEN'] || 'please set auth token',
  admin: {
    name: ENV['BULLSEYE_ADMIN_NAME'] || 'admin',
    password: ENV['BULLSEYE_ADMIN_PASSWORD'] || 'password'
  }
}
