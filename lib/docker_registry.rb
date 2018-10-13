require 'net/https'
require 'uri'

module DockerRegistry
  def self.get_token(scope)
    bullseye_config = Rails.application.config.bullseye
    # XXX: some parameters are not url encoded...
    uri = URI.parse("https://#{bullseye_config[:docker_registry_auth_host]}/auth?account=#{bullseye_config[:admin][:name]}&scope=#{scope}&service=Docker%20registry")
    # TODO: SSL should be verified!!!!
    res = Net::HTTP.start(uri.host, uri.port, use_ssl: true, verify_mode: OpenSSL::SSL::VERIFY_NONE) { |http|
      req = Net::HTTP::Get.new(uri)
      req.basic_auth(bullseye_config[:admin][:name], bullseye_config[:admin][:password])
      http.request(req)
    }
    body = JSON.parse(res.body)
    body['token']
  end

  def self.get_latest_info(team_name, exploit_container_name)
    scope = "repository:#{team_name}/#{exploit_container_name}:pull"
    print scope
    token = get_token(scope)
    puts token

    bullseye_config = Rails.application.config.bullseye
    uri = URI("https://#{bullseye_config[:docker_registry_host]}/v2/#{team_name}/#{exploit_container_name}/manifests/latest")
    # TODO: SSL should be verified!!!!
    res = Net::HTTP.start(uri.host, uri.port, use_ssl: true, verify_mode: OpenSSL::SSL::VERIFY_NONE) { |http|
      req = Net::HTTP::Get.new(uri)
      req['Authorization'] = "Bearer #{token}"
      http.request(req)
    }
    JSON.parse(res.body)
  end
end