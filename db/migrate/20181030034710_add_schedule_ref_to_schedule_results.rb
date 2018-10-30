class AddScheduleRefToScheduleResults < ActiveRecord::Migration[5.2]
  def change
    remove_column :schedule_results, :schedule_id, :integer
    add_reference :schedule_results, :schedule, foreign_key: true
  end
end
