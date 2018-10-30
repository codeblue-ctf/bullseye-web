class AddScoreToScheduleResults < ActiveRecord::Migration[5.2]
  def change
    add_column :schedule_results, :score, :integer

    add_column :schedule_results, :failed, :integer
    add_column :problems, :calc_formula, :string
  end
end
