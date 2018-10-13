module DockerRegistry
  def login(team_name, problem_name)
    curl -u "<teamId>:<teamToekn>" "https://<DOCKER_REGISTRY_AUTH>/auth?account=<teamId>&scope=repository:binja/hello-world:pull&service=Docker%20registry" -k
  end

  def get_latest_info(team_name, problem_name)
    token = login(team_name, problem_name)
    curl http://<DOCKER_REGISTRY>/v2/binja/hello-world/manifests/latest -H "Authorization: Bearer <token>"
  end
end