Rails.application.config.bullseye = {
  bullseye_runner_host: ENV.fetch('BULLSEYE_RUNNER_HOST') { 'localhost:3001' },
  docker_registry_host: ENV.fetch('DOCKER_REGISTRY_HOST') { 'localhost:5000' },
  docker_registry_auth_host: ENV.fetch('DOCKER_REGISTRY_AUTH_HOST') { 'localhost:5001' },
  admin: {
    name: ENV.fetch('BULLSEYE_ADMIN_NAME') { 'admin' },
    password: ENV.fetch('BULLSEYE_ADMIN_PASSWORD') { 'password' }
  }
}
