module DockerComposeTemplate
  def render(docker_compose, params)
    docker_compose.gsub(/{{teamId}}/, params[:team_login_name])
  end
end