class AddX11RequiredFlagToProblem < ActiveRecord::Migration[5.2]
  def change
    add_column :problems, :x11_required, :boolean
  end
end
