class AddScoreToScheduleResults < ActiveRecord::Migration[5.2]
  def change
    add_column :schedule_results, :score, :integer

    add_column :schedule_results, :failed, :integer
    add_column :problems, :calc_formula, :text, null: true

    rename_column :schedule_results, :start_at, :runner_started_at
    rename_column :schedule_results, :finished_at, :runner_finished_at
  end
end
