class AddRunnerurlToSchdule < ActiveRecord::Migration[5.2]
  def change
    add_column :schedules, :runner_host, :string
  end
end
