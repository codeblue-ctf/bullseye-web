class RemoveCurrentRoundColumnFromSchedulesTable < ActiveRecord::Migration[5.2]
  def change
    remove_column :schedules, :current_round, :integer
  end
end
