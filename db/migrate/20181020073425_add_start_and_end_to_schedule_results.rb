class AddStartAndEndToScheduleResults < ActiveRecord::Migration[5.2]
  def change
    add_column :schedule_results, :start_at, :datetime
    add_column :schedule_results, :finished_at, :datetime
  end
end
