class SchedulesController < ApplicationController
  def new_macro
    @schedule = Schedule.new
    @problems = Problem.all
    @teams = Team.all
    @start_times = Round.all.pluck(:start_at)
  end

  def create_macro
    params[:start_times].each do |start_time|
      Schedule.create(
        teams: params[:teams].to_json,
        problems: params[:problems].to_json,
        start_at: start_time
      )
    end
  end
end
