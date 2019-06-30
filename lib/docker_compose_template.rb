module DockerComposeTemplate
  def self.render(docker_compose, params)
    return nil if docker_compose.nil?

    docker_compose % params
  end
end