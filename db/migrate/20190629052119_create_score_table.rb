class CreateScoreTable < ActiveRecord::Migration[5.2]
  def change
    create_table :score do |t|
      t.integer :score
      t.integer :image_id
      t.integer :succeeded
      t.integer :failed
      t.datetime :runner_started_at
      t.datetime :runner_finished_at
      t.timestamps null: false
    end
  end
end
