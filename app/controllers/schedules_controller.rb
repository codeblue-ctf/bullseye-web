class SchedulesController < ApplicationController
  def new_macro
    @problems = Problem.all
    @teams = Team.all
    @start_times = Round.all.map { |round| ["#{round.label} (#{round.start_at})", round.start_at] }
  end

  def create_macro
    bullseye_config = Rails.application.config.bullseye
    teams = Team.where(id: params[:teams])
    problems = Problem.where(id: params[:problems])
    teams.each do |team|
      problems.each do |problem|
        # format docker compose template to runner's one
        yml = DockerComposeTemplate::format_to_runner_template(problem.docker_compose)

        RunnerMaster::create_schedule(
          start_at: Time.parse(params[:start_at]).utc.iso8601, # TODO: get time from round id
          stop_at: Time.parse(params[:stop_at]).utc.iso8601, # TODO: this should be JST
          yml: yml,
          interval: params[:interval].to_i,
          ntrials: problem.ntrials,
          timeout: problem.timeout,
          worker_hosts: params[:worker_hosts],
          registry_host: bullseye_config[:docker_registry_host],
          registry_username: bullseye_config[:admin][:name],
          registry_password: bullseye_config[:admin][:password],
          callback_url: "",
          team: team.login_name,
          problem: problem.exploit_container_name,
        )
      end
    end
  end
end
