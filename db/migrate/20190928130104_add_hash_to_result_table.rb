class AddHashToResultTable < ActiveRecord::Migration[5.2]
  def change
    rename_table :schedule_results, :results
    remove_column :results, :schedule_id, :integer
    remove_column :results, :round, :integer
    add_column :results, :team_id, :integer
    add_column :results, :problem_id, :integer
    add_column :results, :image_digest, :string
    add_column :results, :log, :text
  end
end
