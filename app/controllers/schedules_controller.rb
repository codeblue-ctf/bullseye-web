class SchedulesController < ApplicationController
  def new_macro
    @schedule = Schedule.new
    @problems = Problem.all
    @teams = Team.all
    @start_times = [
      '10:00',
      '12:00',
      '14:00',
      '16:00',
      '18:00'
    ]
  end

  def create_macro
    @schedules = Team.all.map do |team|
      params[:schedule][:team_id] = team.id
      params[:schedule][:runner_host] = team.default_runner
      Schedule.create(schedule_params)
    end
  end

  private
  def schedule_params
    params.require(:schedule).permit(:problem_id, :team_id, :start_at, :finish_at, :interval, :runner_host)
  end
end
