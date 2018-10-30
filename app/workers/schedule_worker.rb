require 'securerandom'
require 'net/https'
require 'uri'
require 'json'

class ScheduleWorker
  include Sidekiq::Worker

  def perform(schedule_id)
    # send request to bullseye-runner
    schedule = Schedule.find(schedule_id)
    team = schedule.team
    problem = schedule.problem

    start_at = schedule.start_at
    finish_at = schedule.finish_at
    interval = schedule.interval
    now = DateTime.now

    if now > finish_at then
      return
    end

    # update schedule
    if schedule.next_jobid != self.jid then
      job = Sidekiq::ScheduledSet.new.find_job(schedule.next_jobid)
      job.delete if job
    end

    # schedule next worker
    if now < start_at then
      schedule.next_jobid = ScheduleWorker.perform_at start_at, schedule_id
      schedule.save
      return
    end

    schedule.next_jobid = ScheduleWorker.perform_in (interval - (now.to_time - start_at.to_time) % interval), schedule_id
    schedule.save

    docker_compose = (problem.docker_compose || "") % {
      team: team.login_name,
      exploit: problem.exploit_container_name,
      problem: problem.problem_container_name
    }

    bullseye_config = Rails.application.config.bullseye
    runner_host = schedule.runner_host || bullseye_config[:runner_host]

    data = {
      id: SecureRandom.uuid,
      trials_count: problem.ntrials,
      timeout: problem.timeout,
      docker_compose: docker_compose,
      callback_url: "http://#{bullseye_config[:web_host]}",
      callback_authorizatoin_token: bullseye_config[:api_authorization_token],
      registry_host: "http://#{bullseye_config[:docker_registry_host]}",
      admin_username: bullseye_config[:admin][:name],
      admin_password: bullseye_config[:admin][:password],
      flag_template: 'CBCTF{{{flag}}}' # XXX: hardcoded...
    }

    # submit to bullseye runner
    result = submit_to_runner(runner_host, data)

    # record result
    ScheduleResult.create(
      schedule_id: schedule.id,
      schedule_uuid: data[:id]
    )

    # increment round counter
    schedule.current_round += 1
  end

  def submit_to_runner(runner_host, data)
    uri = URI("http://#{runner_host}")
    res = Net::HTTP.start(uri.host, uri.port) { |http|
      req = Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json')
      req.body = data.to_json
      http.request(req)
    }
    JSON.parse(res.body)
  end
end
