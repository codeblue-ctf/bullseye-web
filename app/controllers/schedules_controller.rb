class SchedulesController < ApplicationController
  def new_macro
    @problems = Problem.all
    @teams = Team.all
    @start_times = Round.all.map { |round| ["#{round.label} (#{round.start_at})", round.start_at] }
  end

  def create_macro
    teams = Team.where(id: params[:teams])
    problems = Problem.where(id: params[:problems])
    teams.each do |team|
      problems.each do |problem|
        # format docker compose template to runner's one
        yml = DockerComposeTemplate::format_to_runner_template(
          problem.docker_compose,
          team: team.login_name
        )

        RunnerMaster::create_schedule(
          team_id: team.login_name,
          problem_id: problem.exploit_container_name,
          start_at: Time.parse(params[:start_at]).iso8601, # TODO: get time from round id
          stop_at: Time.parse(params[:stop_at]).iso8601, # TODO: this should be JST
          yml: yml,
          interval: params[:interval].to_i,
          ntrials: problem.ntrials,
          timeout: problem.timeout,
          worker_hosts: params[:worker_hosts],
        )
      end
    end
  end
end
