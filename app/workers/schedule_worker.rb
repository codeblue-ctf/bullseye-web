class ScheduleWorker
  include Sidekiq::Worker

  def perform(schedule_id)
    # send request to bullseye-runner
    schedule = Schedule.find(schedule_id)
    team_id = schedule.team_id
    problem_id = schedule.problem_id

    puts "executed: #{schedule}"
  end
end
