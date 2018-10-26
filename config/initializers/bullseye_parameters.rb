runner_host = ENV.fetch('BULLSEYE_RUNNER_HOST') { 'localhost:3001' },

Rails.application.config.bullseye = {
  runner_host: runner_host,
  docker_registry_host: ENV.fetch('DOCKER_REGISTRY_HOST') { 'localhost:5000' },
  docker_registry_auth_host: ENV.fetch('DOCKER_REGISTRY_AUTH_HOST') { 'localhost:5001' },
  api_authorization_token: ENV.fetch('BULLSEYE_API_AUTH_TOKEN') { 'please set auth token' },
  admin: {
    name: ENV.fetch('BULLSEYE_ADMIN_NAME') { 'admin' },
    password: ENV.fetch('BULLSEYE_ADMIN_PASSWORD') { 'password' }
  },
  runner_start_endpoint: "#{runner_host}/"
}
