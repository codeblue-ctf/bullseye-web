class CreateSchedules < ActiveRecord::Migration[5.2]
  def change
    create_table :schedules do |t|
      t.references :team, foreign_key: true
      t.references :problem, foreign_key: true
      t.timestamp :start_at
      t.timestamp :finish_at
      t.integer :interval

      t.timestamps
    end
  end
end
