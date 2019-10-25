class ChangeRunnerResultIdColumn < ActiveRecord::Migration[5.2]
  def change
    rename_column :scores, :runner_result_id, :runner_round_id
  end
end
