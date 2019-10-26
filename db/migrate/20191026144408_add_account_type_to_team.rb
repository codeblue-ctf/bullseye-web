class AddAccountTypeToTeam < ActiveRecord::Migration[5.2]
  def change
    add_column :teams, :account_type, :integer, default: 0
  end
end
