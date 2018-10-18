require 'securerandom'

class ScheduleWorker
  include Sidekiq::Worker

  def perform(schedule_id)
    # send request to bullseye-runner
    schedule = Schedule.find(schedule_id)
    team_id = schedule.team_id
    problem_id = schedule.problem_id


    start_at = schedule.start_at
    finish_at = schedule.finish_at
    interval = schedule.interval
    now = DateTime.now

    if now > finish_at then
      return
    end

    # schedule next worker
    if now < start_at then
      ScheduleWorker.perform_at start_at, schedule_id
      return
    else
      ScheduleWorker.perform_in (interval - (now.to_time - start_at.to_time) % interval), schedule_id
    end

    data = {
      :id => SecureRandom.uuid,
      :trials => schedule.problem.ntrials,
      :timeout => schedule.problem.timeout,
      :docker_compose => schedule.problem.docker_compose,
    }
    p data

    # record submit log
  end
end
