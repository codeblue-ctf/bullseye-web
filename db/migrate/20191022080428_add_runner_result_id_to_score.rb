class AddRunnerResultIdToScore < ActiveRecord::Migration[5.2]
  def change
    add_column :scores, :runner_result_id, :int
    add_index :scores, :runner_result_id, unique: true
  end
end
