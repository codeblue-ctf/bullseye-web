class AddDefaultRunnerToTeams < ActiveRecord::Migration[5.2]
  def change
    add_column :teams, :default_runner, :string
  end
end
