module DockerComposeTemplate
  def self.render(docker_compose, params)
    docker_compose % params
  end
end