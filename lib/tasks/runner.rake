require 'securerandom'
require 'net/https'
require 'uri'
require 'json'

namespace :runner do
  task :send, ['problem_id', 'team_id', 'runner_host'] => :environment do |task, args|
    problem = Problem.find(args.problem_id)
    team = Team.find(args.team_id)
    runner_host = args.runner_host

    bullseye_config = Rails.application.config.bullseye
    docker_compose = (problem.docker_compose || "") % {
      team: team.login_name,
      exploit: problem.exploit_container_name,
      problem: problem.problem_container_name
    }

    data = {
      id: SecureRandom.uuid,
      trials_count: problem.ntrials,
      timeout: problem.timeout,
      docker_compose: docker_compose,
      callback_url: "http://#{bullseye_config[:web_host]}/internal_api/v1/submit_score",
      callback_authorization_token: bullseye_config[:api_authorization_token],
      registry_host: "http://#{bullseye_config[:docker_registry_host]}",
      admin_username: bullseye_config[:admin][:name],
      admin_password: bullseye_config[:admin][:password],
      flag_template: 'CBCTF{{{flag}}}' # XXX: hardcoded...
    }

    uri = URI("http://#{runner_host}")
    res = Net::HTTP.start(uri.host, uri.port) { |http|
      req = Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json')
      req.body = data.to_json
      http.request(req)
    }
    JSON.parse(res.body)

    ScheduleResult.create(
      schedule_uuid: data[:id]
    )
  end
end
