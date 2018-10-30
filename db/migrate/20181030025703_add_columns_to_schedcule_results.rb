class AddColumnsToSchedculeResults < ActiveRecord::Migration[5.2]
  def change
    add_column :schedule_results, :schedule_uuid, :string, null: false, default: ""
    rename_column :schedule_results, :score, :succeeded
    
    add_column :schedules, :current_round, :integer, default: 0
    add_column :schedules, :next_jobid, :string
  end
end
