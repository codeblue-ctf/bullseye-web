class DeleteDockerRegistryTokenFromTeams < ActiveRecord::Migration[5.2]
  def change
    remove_column :teams, :docker_registry_token, :string
  end
end
