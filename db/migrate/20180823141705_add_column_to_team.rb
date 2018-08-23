class AddColumnToTeam < ActiveRecord::Migration[5.2]
  def change
    add_column :teams, :docker_registry_token, :string
  end
end
