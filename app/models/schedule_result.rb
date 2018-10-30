class ScheduleResult < ApplicationRecord
  belongs_to :schedule

  before_update do |record|
    succeeded = record.succeeded
    failed = record.failed

    unless succeeded.nil? or failed.nil? then
      f = eval("lambda do; #{record.schedule.problem.calc_formula}; end")

      # prepare variables for calc_formula
      succeeded = record.succeeded
      failed = record.failed
      runner_started_at = record.runner_started_at
      runner_finished_at = record.runner_finished_at

      record.score = f.call
    end
  end
end
