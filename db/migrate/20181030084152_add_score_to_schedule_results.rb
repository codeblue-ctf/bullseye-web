class AddScoreToScheduleResults < ActiveRecord::Migration[5.2]
  def change
    add_column :schedule_results, :score, :integer

    add_column :schedule_results, :failed, :integer
    add_column :problems, :calc_formula, :text, default: "# available variables: succeeded, failed, started_at, finished_at\n1000*succeeded/(succeeded + failed)", null: false

    rename_column :schedule_results, :start_at, :runner_started_at
    rename_column :schedule_results, :finished_at, :runner_finished_at
  end
end
