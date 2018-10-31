require './lib/docker_compose_template'

module ProblemsHelper
  def render_docker_compose_template(docker_compose, params)
    DockerComposeTemplate::render(docker_compose, params)
  end
end
