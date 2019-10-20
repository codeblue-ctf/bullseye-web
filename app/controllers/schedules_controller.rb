class SchedulesController < ApplicationController
  def new_macro
    @problems = Problem.all
    @teams = Team.all
    @start_times = Round.all.pluck(:start_at)
  end

  def create_macro
    params[:teams].each do |team|
      Problem.where(id: params[:problems]).each do |problem|
        RunnerMaster::create_schedule(
          team_id: team,
          problem_id: problem.id,
          start_at: params[:start_at].iso8601,
          stop_at: params[:stop_at].iso8601,
          yml: problem.docker_compose,
          interval: params[:interval],
          ntrials: problem.ntrials,
          timeout: problem.timeout,
          worker_hosts: params[:worker_hosts],
        )
      end
    end
  end
end
