class SchedulesController < ApplicationController
  def new_macro
    @problems = Problem.all
    @teams = Team.all
    @start_times = Round.all.map { |round| ["#{round.label} (#{round.start_at})", round.start_at] }
    @runner_workers = RunnerWorker.all
  end

  def create_macro
    bullseye_config = Rails.application.config.bullseye
    teams = Team.where(id: params[:teams])
    problems = Problem.where(id: params[:problems])
    worker_hosts = params[:worker_hosts].join(',') # worker hosts should be , separated string
    teams.each do |team|
      problems.each do |problem|
        # format docker compose template to runner's one
        yml = DockerComposeTemplate::format_to_runner_template(problem.docker_compose)
        start_at = Time.parse(params[:start_at]).utc.iso8601
        # XXX: input is local time. add local timezone for now
        stop_at = Time.parse(params[:stop_at] + " +0900").utc.iso8601

        RunnerMaster::create_schedule(
          start_at: start_at,
          stop_at: stop_at,
          yml: yml,
          interval: params[:interval].to_i,
          ntrials: problem.ntrials,
          timeout: problem.timeout,
          worker_hosts: worker_hosts,
          registry_host: bullseye_config[:docker_registry_host],
          registry_username: bullseye_config[:admin][:name],
          registry_password: bullseye_config[:admin][:password],
          callback_url: "",
          team: team.login_name,
          problem: problem.exploit_container_name,
          x11_required: problem.x11_required,
        )
      end
    end
  end

  def list
    @schedules = RunnerMaster::get_schedules
  end

  def delete
    params[:schedule_ids].each do |schedule_id|
      RunnerMaster::delete_schedule(schedule_id)
    end
    redirect_to action: 'list'
  end
end
