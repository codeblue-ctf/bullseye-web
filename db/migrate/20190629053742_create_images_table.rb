class CreateImagesTable < ActiveRecord::Migration[5.2]
  def change
    create_table :images do |t|
      t.string :image_digest
      t.integer :team_id
      t.integer :problem_id
      t.datetime :uploaded_at
      t.string :event_log
      t.timestamps null: false
    end
  end
end
