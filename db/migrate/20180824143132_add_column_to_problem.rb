class AddColumnToProblem < ActiveRecord::Migration[5.2]
  def change
    add_column :problems, :score, :integer
    add_column :problems, :exploit_timeout, :integer
    add_column :problems, :exploit_trial_count, :integer
  end
end
