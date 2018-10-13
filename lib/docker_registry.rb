require 'net/https'
require 'uri'

module DockerRegistry
  def self.login(team_name, problem_name)
    bullseye_config = Rails.application.config.bullseye
    uri = URI.parse("https://#{bullseye_config[:docker_registry_auth_host]}/auth?account=#{bullseye_config[:admin][:name]}&scope=repository:#{team_name}/#{problem_name}:pull&service=Docker%20registry")
    res = Net::HTTP.start(uri.host, uri.port, use_ssl: true, verify_mode: OpenSSL::SSL::VERIFY_NONE) { |http|
      req = Net::HTTP::Get.new(uri)
      req.basic_auth(bullseye_config[:admin][:name], bullseye_config[:admin][:password])
      http.request(req)
    }
    body = JSON.parse(res.body)
    body['token']
  end

  def self.get_latest_info(team_name, problem_name)
    token = login(team_name, problem_name)
    print(token)
    # curl http://<DOCKER_REGISTRY>/v2/binja/hello-world/manifests/latest -H "Authorization: Bearer <token>"
  end
end