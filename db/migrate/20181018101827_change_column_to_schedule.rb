class ChangeColumnToSchedule < ActiveRecord::Migration[5.2]
  def change
    change_column :schedules, :start_at, :datetime, null: false
    change_column :schedules, :finish_at, :datetime, null: false
    change_column :schedules, :interval, :integer, null: false
  end
end
