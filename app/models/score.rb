class Score < ApplicationRecord
  def calc_score(calc_formula)
    unless self.succeeded.nil? or self.failed.nil? then
      f = eval("lambda do; #{calc_formula}; end")

      # prepare variables for calc_formula
      succeeded = self.succeeded
      failed = self.failed
      runner_started_at = self.runner_started_at
      runner_finished_at = self.runner_finished_at

      begin
        return f.call
      rescue
      end
    end
  end
end
