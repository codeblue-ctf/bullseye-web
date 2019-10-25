class AddTeamNameToScore < ActiveRecord::Migration[5.2]
  def change
    add_column :scores, :team_login_name, :string
    add_column :scores, :problem_name, :string
  end
end
