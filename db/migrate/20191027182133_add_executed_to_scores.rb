class AddExecutedToScores < ActiveRecord::Migration[5.2]
  def change
    add_column :scores, :executed, :integer
  end
end
