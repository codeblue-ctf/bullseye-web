class AddNameToTeam < ActiveRecord::Migration[5.2]
  def change
    add_column :teams, :name, :string
  end
end
