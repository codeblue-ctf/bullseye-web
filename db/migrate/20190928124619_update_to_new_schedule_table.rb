class UpdateToNewScheduleTable < ActiveRecord::Migration[5.2]
  def change
    remove_column :schedules, :team_id, :integer
    remove_column :schedules, :problem_id, :integer
    remove_column :schedules, :finish_at, :datetime
    remove_column :schedules, :interval, :integer
    remove_column :schedules, :runner_host, :string
    remove_column :schedules, :concurrency, :integer

    add_column :schedules, :teams, :string
    add_column :schedules, :problems, :string
  end
end
