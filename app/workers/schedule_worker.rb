require 'securerandom'
require 'net/https'
require 'uri'
require 'json'

class ScheduleWorker
  include Sidekiq::Worker

  def perform(schedule_id)
    # send request to bullseye-runner
    schedule = Schedule.find(schedule_id)
    team_id = schedule.team_id
    problem_id = schedule.problem_id


    start_at = schedule.start_at
    finish_at = schedule.finish_at
    interval = schedule.interval
    now = DateTime.now

    if now > finish_at then
      return
    end

    # schedule next worker
    if now < start_at then
      ScheduleWorker.perform_at start_at, schedule_id
      return
    else
      ScheduleWorker.perform_in (interval - (now.to_time - start_at.to_time) % interval), schedule_id
    end

    # TODO: perform when the job did not perform for this turn

    # TODO: build docker_compose with team information

    data = {
      id: SecureRandom.uuid,
      trials_count: schedule.problem.ntrials,
      timeout: schedule.problem.timeout,
      docker_compose: schedule.problem.docker_compose,
      callback_url: '', # TODO: write
      callback_authorization_token: '', # TODO: write,
      registry_host: '', # TODO: write
      admin_username: '', # TODO: write
      admin_password: '', # TODO: write
      flag_template: 'CBCTF{{{flag}}}' # XXX: hardcoded...
    }
    puts data

    # submit to bullseye runner
    result = submit_to_runner(data)

    # TODO: record submit log
  end

  def submit_to_runner(data)
    bullseye_config = Rails.application.config.bullseye
    uri = URI("http://#{bullseye_config[:runner_start_endpoint]}")
    res = Net::HTTP.start(uri.host, uri.port) { |http|
      req = Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json')
      req.body = data.to_json
      http.request(req)
    }
    JSON.parse(res.body)
  end
end
