class CreateRunnerWorkerTable < ActiveRecord::Migration[5.2]
  def change
    create_table :runner_workers do |t|
      t.string :host
    end
  end
end
