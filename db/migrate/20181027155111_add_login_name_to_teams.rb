class AddLoginNameToTeams < ActiveRecord::Migration[5.2]
  def change
    add_column :teams, :login_name, :string
  end
end
