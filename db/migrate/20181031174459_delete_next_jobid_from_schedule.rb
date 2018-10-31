class DeleteNextJobidFromSchedule < ActiveRecord::Migration[5.2]
  def change
    remove_column :schedules, :next_jobid, :string
  end
end
