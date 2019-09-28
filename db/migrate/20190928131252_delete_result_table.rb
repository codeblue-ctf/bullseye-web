class DeleteResultTable < ActiveRecord::Migration[5.2]
  def change
    drop_table :results
  end
end
