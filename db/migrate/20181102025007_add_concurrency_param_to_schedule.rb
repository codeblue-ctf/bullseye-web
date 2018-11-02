class AddConcurrencyParamToSchedule < ActiveRecord::Migration[5.2]
  def change
    add_column :schedules, :concurrency, :integer
  end
end
