class AddTimestampsToScheduleResults < ActiveRecord::Migration[5.2]
  def change
    add_column :schedule_results, :created_at, :datetime
    add_column :schedule_results, :updated_at, :datetime
  end
end
