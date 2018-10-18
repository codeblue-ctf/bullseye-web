class RenameScheduleColumn < ActiveRecord::Migration[5.2]
  def change
    rename_column :problems, :exploit_trial_count, :ntrials
    rename_column :problems, :exploit_timeout, :timeout
  end
end
