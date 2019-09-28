class SchedulesController < ApplicationController
  def new_macro
    @schedule = Schedule.new
    @problems = Problem.all
    @teams = Team.all
    @start_times = Round.all.pluck(:start_at)
  end

  def create_macro
    Schedule.create(
      teams: params[:teams].to_json,
      problems: params[:problems].to_json,
      start_times: params[:start_times].to_json
    )
  end
end
