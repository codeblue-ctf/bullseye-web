class CreateRoundTable < ActiveRecord::Migration[5.2]
  def change
    create_table :rounds do |t|
      t.string :label
      t.datetime :start_at
      t.boolean :disabled
    end
  end
end
