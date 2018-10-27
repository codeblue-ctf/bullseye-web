class AddLoginNameUniqueIndexToTeams < ActiveRecord::Migration[5.2]
  def change
    add_index :teams, :login_name, unique: true
  end
end
