class AddRoundToScheduleResult < ActiveRecord::Migration[5.2]
  def change
    add_column :schedule_results, :round, :integer
  end
end
