class DeleteScheduleTable < ActiveRecord::Migration[5.2]
  def change
    drop_table :schedules
  end
end
