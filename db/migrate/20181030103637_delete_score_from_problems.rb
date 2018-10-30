class DeleteScoreFromProblems < ActiveRecord::Migration[5.2]
  def change
    remove_column :problems, :score, :integer
  end
end
