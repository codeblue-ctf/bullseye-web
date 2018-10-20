class CreateScheduleResults < ActiveRecord::Migration[5.2]
  def change
    create_table :schedule_results do |t|
      t.integer :schedule_id
      t.integer :score
      t.text :error
    end
  end
end
