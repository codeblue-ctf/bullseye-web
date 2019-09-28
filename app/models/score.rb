class Score < ApplicationRecord
  before_update do |record|
    # TODO: maybe no need to calc score in this time instead of viewer
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
