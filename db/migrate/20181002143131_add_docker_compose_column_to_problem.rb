class AddDockerComposeColumnToProblem < ActiveRecord::Migration[5.2]
  def change
    add_column :problems, :docker_compose, :text
    add_column :problems, :exploit_container_name, :string
    add_column :problems, :problem_container_name, :string
  end
end
