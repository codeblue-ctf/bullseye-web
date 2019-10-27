class AddFlagTemplateToProblems < ActiveRecord::Migration[5.2]
  def change
    add_column :problems, :flag_template, :string, default: 'CBCTF{[a-z]{16}}'
  end
end
