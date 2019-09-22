class ScheduleResult < ApplicationRecord
  belongs_to :schedule

  before_create do
    # XXX: Comment out Round because Round is deprecated
    # XXX: We will refactoring schedule this model
    # self.round_id = Round.last.id
  end

  before_update do |record|
    succeeded = record.succeeded
    failed = record.failed

    unless succeeded.nil? or failed.nil? then
      problem = Problem.find(record.schedule.problem_id)
      f = eval("lambda do; #{problem.calc_formula}; end")

      # prepare variables for calc_formula
      succeeded = record.succeeded
      failed = record.failed
      runner_started_at = record.runner_started_at
      runner_finished_at = record.runner_finished_at

      begin
        record.score = f.call
      rescue
      end
    end
  end
end
