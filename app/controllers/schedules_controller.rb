class SchedulesController < ApplicationController
  def new_macro
    @problems = Problem.all
    @teams = Team.all
    @start_times = Round.all.pluck(:start_at)
  end

  def create_macro
    params[:teams].each do |team|
      Problem.where(id: params[:problems]).each do |problem|
        yml = DockerComposeTemplate::format_to_runner_template(problem.docker_compose, team: team)
        RunnerMaster::create_schedule(
          team_id: team.to_s,
          problem_id: problem.id.to_s,
          start_at: Time.parse(params[:start_at]).iso8601, # TODO: get time from round id
          stop_at: Time.parse(params[:stop_at]).iso8601,
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
